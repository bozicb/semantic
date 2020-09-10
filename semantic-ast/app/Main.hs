{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Main (main) where

import AST.GenerateSyntax
import Control.Lens (Traversal', mapped, (%~))
import Data.Generics.Product.Typed (typed)
import Data.Maybe
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import GHC.Generics (Generic)
import Language.Haskell.TH
import Language.Haskell.TH.Lens
import NeatInterpolation
import qualified Options.Generic as Opt
import System.Directory
import System.IO
import System.Process
import qualified TreeSitter.JSON as JSON (tree_sitter_json)

data Config = Config {language :: Text, path :: FilePath}
  deriving stock (Show, Generic)
  deriving anyclass (Opt.ParseRecord)

-- There are a few cases where the output emitted by TH's 'pprint' doesn't
-- create entirely valid Haskell syntax, because sometimes we get
-- a qualified name on the LHS of a typeclass declaration, which Haskell
-- doesn't like at all. I haven't figured out quite why we get this qualified
-- name, but for now the simplest thing to do is some neste dupdates
adjust :: [Dec] -> [Dec]
adjust = mapped._InstanceD.typed.mapped %~ (values %~ truncate) . (functions %~ truncate)
  where
    -- Need to handle functions with no arguments, which are parsed as ValD entities,
    -- as well as those with arguments, which are FunD.
    values, functions :: Traversal' Dec Name
    values = _ValD.typed._VarP
    functions = _FunD.typed

    truncate :: Name -> Name
    truncate = mkName . nameBase

main :: IO ()
main = do
  Config language path <- Opt.getRecord "generate-ast"
  decls <- T.pack . pprint . adjust <$> astDeclarationsIO JSON.tree_sitter_json path

  let programText =
        [trimming|
-- Language definition for $language, generated by ast-generate. Do not edit!
{-# LANGUAGE CPP #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveTraversable #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuantifiedConstraints #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}

module Language.$language.AST (module Language.$language.AST) where

import qualified AST.Parse
import qualified AST.Token
import qualified AST.Traversable1.Class
import qualified AST.Unmarshal
import qualified Data.Foldable
import qualified Data.List as Data.OldList
import qualified Data.Maybe as GHC.Maybe
import qualified Data.Text.Internal
import qualified Data.Traversable
import qualified GHC.Base
import qualified GHC.Generics
import qualified GHC.Records
import qualified GHC.Show
import qualified Prelude as GHC.Classes
import qualified TreeSitter.Node

debugSymbolNames :: [GHC.Base.String]
debugSymbolNames = debugSymbolNames_0

$decls
  |]
  hasOrmolu <- findExecutable "ormolu"
  if isNothing hasOrmolu
    then do
      T.putStrLn programText
      hPutStrLn stderr "generate-ast: No `ormolu` executable found, output will look janky."
    else do
      (path, tf) <- openTempFile "/tmp" "generated.hs"
      T.hPutStrLn tf programText
      hClose tf
      callProcess "ormolu" ["--mode", "inplace", path]
      T.readFile path >>= T.putStrLn
