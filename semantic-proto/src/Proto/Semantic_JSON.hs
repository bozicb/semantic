-- Code generated by protoc-gen-jsonpb_haskell 0.1.0, DO NOT EDIT.
{-# OPTIONS_GHC -Wno-orphans -Wno-unused-imports -Wno-missing-export-lists #-}
module Proto.Semantic_JSON where

import           Prelude(($), (.), (<$>), pure, show, Maybe(..))

import           Data.ProtoLens.Runtime.Lens.Family2 ((^.), (.~), (&))
import           Data.Monoid (mconcat)
import           Control.Monad (msum)
import           Data.ProtoLens (defMessage)
import qualified Data.Aeson as A
import qualified Data.Aeson.Encoding as E
import           Data.ProtoLens.JSONPB as JSONPB
import qualified Data.Text as T

import           Proto.Semantic as P
import           Proto.Semantic_Fields as P

instance FromJSONPB PingRequest where
  parseJSONPB = withObject "PingRequest" $ \obj -> do
    service' <- obj .: "service"
    pure $ defMessage
      & P.service .~ service'

instance ToJSONPB PingRequest where
  toJSONPB x = object
    [ "service" .= (x^.service)
    ]
  toEncodingPB x = pairs
    [ "service" .= (x^.service)
    ]

instance FromJSON PingRequest where
  parseJSON = parseJSONPB

instance ToJSON PingRequest where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB PingResponse where
  parseJSONPB = withObject "PingResponse" $ \obj -> do
    status' <- obj .: "status"
    hostname' <- obj .: "hostname"
    timestamp' <- obj .: "timestamp"
    sha' <- obj .: "sha"
    pure $ defMessage
      & P.status .~ status'
      & P.hostname .~ hostname'
      & P.timestamp .~ timestamp'
      & P.sha .~ sha'

instance ToJSONPB PingResponse where
  toJSONPB x = object
    [ "status" .= (x^.status)
    , "hostname" .= (x^.hostname)
    , "timestamp" .= (x^.timestamp)
    , "sha" .= (x^.sha)
    ]
  toEncodingPB x = pairs
    [ "status" .= (x^.status)
    , "hostname" .= (x^.hostname)
    , "timestamp" .= (x^.timestamp)
    , "sha" .= (x^.sha)
    ]

instance FromJSON PingResponse where
  parseJSON = parseJSONPB

instance ToJSON PingResponse where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB ParseTreeRequest where
  parseJSONPB = withObject "ParseTreeRequest" $ \obj -> do
    blobs' <- obj .: "blobs"
    pure $ defMessage
      & P.blobs .~ blobs'

instance ToJSONPB ParseTreeRequest where
  toJSONPB x = object
    [ "blobs" .= (x^.blobs)
    ]
  toEncodingPB x = pairs
    [ "blobs" .= (x^.blobs)
    ]

instance FromJSON ParseTreeRequest where
  parseJSON = parseJSONPB

instance ToJSON ParseTreeRequest where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB ParseTreeSymbolResponse where
  parseJSONPB = withObject "ParseTreeSymbolResponse" $ \obj -> do
    files' <- obj .: "files"
    pure $ defMessage
      & P.files .~ files'

instance ToJSONPB ParseTreeSymbolResponse where
  toJSONPB x = object
    [ "files" .= (x^.files)
    ]
  toEncodingPB x = pairs
    [ "files" .= (x^.files)
    ]

instance FromJSON ParseTreeSymbolResponse where
  parseJSON = parseJSONPB

instance ToJSON ParseTreeSymbolResponse where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB ParseTreeGraphResponse where
  parseJSONPB = withObject "ParseTreeGraphResponse" $ \obj -> do
    files' <- obj .: "files"
    pure $ defMessage
      & P.files .~ files'

instance ToJSONPB ParseTreeGraphResponse where
  toJSONPB x = object
    [ "files" .= (x^.files)
    ]
  toEncodingPB x = pairs
    [ "files" .= (x^.files)
    ]

instance FromJSON ParseTreeGraphResponse where
  parseJSON = parseJSONPB

instance ToJSON ParseTreeGraphResponse where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB StackGraphRequest where
  parseJSONPB = withObject "StackGraphRequest" $ \obj -> do
    blobs' <- obj .: "blobs"
    pure $ defMessage
      & P.blobs .~ blobs'

instance ToJSONPB StackGraphRequest where
  toJSONPB x = object
    [ "blobs" .= (x^.blobs)
    ]
  toEncodingPB x = pairs
    [ "blobs" .= (x^.blobs)
    ]

instance FromJSON StackGraphRequest where
  parseJSON = parseJSONPB

instance ToJSON StackGraphRequest where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB StackGraphResponse where
  parseJSONPB = withObject "StackGraphResponse" $ \obj -> do
    files' <- obj .: "files"
    pure $ defMessage
      & P.files .~ files'

instance ToJSONPB StackGraphResponse where
  toJSONPB x = object
    [ "files" .= (x^.files)
    ]
  toEncodingPB x = pairs
    [ "files" .= (x^.files)
    ]

instance FromJSON StackGraphResponse where
  parseJSON = parseJSONPB

instance ToJSON StackGraphResponse where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB ParseTreeFileGraph where
  parseJSONPB = withObject "ParseTreeFileGraph" $ \obj -> do
    path' <- obj .: "path"
    language' <- obj .: "language"
    vertices' <- obj .: "vertices"
    edges' <- obj .: "edges"
    errors' <- obj .: "errors"
    pure $ defMessage
      & P.path .~ path'
      & P.language .~ language'
      & P.vertices .~ vertices'
      & P.edges .~ edges'
      & P.errors .~ errors'

instance ToJSONPB ParseTreeFileGraph where
  toJSONPB x = object
    [ "path" .= (x^.path)
    , "language" .= (x^.language)
    , "vertices" .= (x^.vertices)
    , "edges" .= (x^.edges)
    , "errors" .= (x^.errors)
    ]
  toEncodingPB x = pairs
    [ "path" .= (x^.path)
    , "language" .= (x^.language)
    , "vertices" .= (x^.vertices)
    , "edges" .= (x^.edges)
    , "errors" .= (x^.errors)
    ]

instance FromJSON ParseTreeFileGraph where
  parseJSON = parseJSONPB

instance ToJSON ParseTreeFileGraph where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB TermEdge where
  parseJSONPB = withObject "TermEdge" $ \obj -> do
    source' <- obj .: "source"
    target' <- obj .: "target"
    pure $ defMessage
      & P.source .~ source'
      & P.target .~ target'

instance ToJSONPB TermEdge where
  toJSONPB x = object
    [ "source" .= (x^.source)
    , "target" .= (x^.target)
    ]
  toEncodingPB x = pairs
    [ "source" .= (x^.source)
    , "target" .= (x^.target)
    ]

instance FromJSON TermEdge where
  parseJSON = parseJSONPB

instance ToJSON TermEdge where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB TermVertex where
  parseJSONPB = withObject "TermVertex" $ \obj -> do
    vertexId' <- obj .: "vertexId"
    term' <- obj .: "term"
    span' <- obj A..:? "span"
    pure $ defMessage
      & P.vertexId .~ vertexId'
      & P.term .~ term'
      & P.maybe'span .~ span'

instance ToJSONPB TermVertex where
  toJSONPB x = object
    [ "vertexId" .= (x^.vertexId)
    , "term" .= (x^.term)
    , "span" .= (x^.maybe'span)
    ]
  toEncodingPB x = pairs
    [ "vertexId" .= (x^.vertexId)
    , "term" .= (x^.term)
    , "span" .= (x^.maybe'span)
    ]

instance FromJSON TermVertex where
  parseJSON = parseJSONPB

instance ToJSON TermVertex where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB ParseError where
  parseJSONPB = withObject "ParseError" $ \obj -> do
    error' <- obj .: "error"
    pure $ defMessage
      & P.error .~ error'

instance ToJSONPB ParseError where
  toJSONPB x = object
    [ "error" .= (x^.error)
    ]
  toEncodingPB x = pairs
    [ "error" .= (x^.error)
    ]

instance FromJSON ParseError where
  parseJSON = parseJSONPB

instance ToJSON ParseError where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB DiffTreeGraphResponse where
  parseJSONPB = withObject "DiffTreeGraphResponse" $ \obj -> do
    files' <- obj .: "files"
    pure $ defMessage
      & P.files .~ files'

instance ToJSONPB DiffTreeGraphResponse where
  toJSONPB x = object
    [ "files" .= (x^.files)
    ]
  toEncodingPB x = pairs
    [ "files" .= (x^.files)
    ]

instance FromJSON DiffTreeGraphResponse where
  parseJSON = parseJSONPB

instance ToJSON DiffTreeGraphResponse where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB DiffTreeFileGraph where
  parseJSONPB = withObject "DiffTreeFileGraph" $ \obj -> do
    path' <- obj .: "path"
    language' <- obj .: "language"
    vertices' <- obj .: "vertices"
    edges' <- obj .: "edges"
    errors' <- obj .: "errors"
    pure $ defMessage
      & P.path .~ path'
      & P.language .~ language'
      & P.vertices .~ vertices'
      & P.edges .~ edges'
      & P.errors .~ errors'

instance ToJSONPB DiffTreeFileGraph where
  toJSONPB x = object
    [ "path" .= (x^.path)
    , "language" .= (x^.language)
    , "vertices" .= (x^.vertices)
    , "edges" .= (x^.edges)
    , "errors" .= (x^.errors)
    ]
  toEncodingPB x = pairs
    [ "path" .= (x^.path)
    , "language" .= (x^.language)
    , "vertices" .= (x^.vertices)
    , "edges" .= (x^.edges)
    , "errors" .= (x^.errors)
    ]

instance FromJSON DiffTreeFileGraph where
  parseJSON = parseJSONPB

instance ToJSON DiffTreeFileGraph where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB DiffTreeEdge where
  parseJSONPB = withObject "DiffTreeEdge" $ \obj -> do
    source' <- obj .: "source"
    target' <- obj .: "target"
    pure $ defMessage
      & P.source .~ source'
      & P.target .~ target'

instance ToJSONPB DiffTreeEdge where
  toJSONPB x = object
    [ "source" .= (x^.source)
    , "target" .= (x^.target)
    ]
  toEncodingPB x = pairs
    [ "source" .= (x^.source)
    , "target" .= (x^.target)
    ]

instance FromJSON DiffTreeEdge where
  parseJSON = parseJSONPB

instance ToJSON DiffTreeEdge where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB DiffTreeVertex'DiffTerm where
  parseJSONPB = A.withObject "DiffTreeVertex'DiffTerm" $ \obj -> mconcat
    [
      DiffTreeVertex'Deleted <$> parseField obj "deleted"
    , DiffTreeVertex'Inserted <$> parseField obj "inserted"
    , DiffTreeVertex'Replaced <$> parseField obj "replaced"
    , DiffTreeVertex'Merged <$> parseField obj "merged"
    ]

instance ToJSONPB DiffTreeVertex'DiffTerm where
  toJSONPB (DiffTreeVertex'Deleted x) = object [ "deleted" .= Just x ]
  toJSONPB (DiffTreeVertex'Inserted x) = object [ "inserted" .= Just x ]
  toJSONPB (DiffTreeVertex'Replaced x) = object [ "replaced" .= Just x ]
  toJSONPB (DiffTreeVertex'Merged x) = object [ "merged" .= Just x ]
  toEncodingPB (DiffTreeVertex'Deleted x) = pairs [ "deleted" .= Just x ]
  toEncodingPB (DiffTreeVertex'Inserted x) = pairs [ "inserted" .= Just x ]
  toEncodingPB (DiffTreeVertex'Replaced x) = pairs [ "replaced" .= Just x ]
  toEncodingPB (DiffTreeVertex'Merged x) = pairs [ "merged" .= Just x ]

instance FromJSON DiffTreeVertex'DiffTerm where
  parseJSON = parseJSONPB

instance ToJSON DiffTreeVertex'DiffTerm where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB DiffTreeVertex where
  parseJSONPB = withObject "DiffTreeVertex" $ \obj -> do
    diffVertexId' <- obj .: "diffVertexId"
    diffTerm' <- obj A..:? "diffTerm"
    pure $ defMessage
      & P.diffVertexId .~ diffVertexId'
      & P.maybe'diffTerm .~ diffTerm'

instance ToJSONPB DiffTreeVertex where
  toJSONPB x = object
    [ "diffVertexId" .= (x^.diffVertexId)
    , "diffTerm" .= (x^.maybe'diffTerm)
    ]
  toEncodingPB x = pairs
    [ "diffVertexId" .= (x^.diffVertexId)
    , "diffTerm" .= (x^.maybe'diffTerm)
    ]

instance FromJSON DiffTreeVertex where
  parseJSON = parseJSONPB

instance ToJSON DiffTreeVertex where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB DeletedTerm where
  parseJSONPB = withObject "DeletedTerm" $ \obj -> do
    term' <- obj .: "term"
    span' <- obj A..:? "span"
    pure $ defMessage
      & P.term .~ term'
      & P.maybe'span .~ span'

instance ToJSONPB DeletedTerm where
  toJSONPB x = object
    [ "term" .= (x^.term)
    , "span" .= (x^.maybe'span)
    ]
  toEncodingPB x = pairs
    [ "term" .= (x^.term)
    , "span" .= (x^.maybe'span)
    ]

instance FromJSON DeletedTerm where
  parseJSON = parseJSONPB

instance ToJSON DeletedTerm where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB InsertedTerm where
  parseJSONPB = withObject "InsertedTerm" $ \obj -> do
    term' <- obj .: "term"
    span' <- obj A..:? "span"
    pure $ defMessage
      & P.term .~ term'
      & P.maybe'span .~ span'

instance ToJSONPB InsertedTerm where
  toJSONPB x = object
    [ "term" .= (x^.term)
    , "span" .= (x^.maybe'span)
    ]
  toEncodingPB x = pairs
    [ "term" .= (x^.term)
    , "span" .= (x^.maybe'span)
    ]

instance FromJSON InsertedTerm where
  parseJSON = parseJSONPB

instance ToJSON InsertedTerm where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB ReplacedTerm where
  parseJSONPB = withObject "ReplacedTerm" $ \obj -> do
    beforeTerm' <- obj .: "beforeTerm"
    beforeSpan' <- obj A..:? "beforeSpan"
    afterTerm' <- obj .: "afterTerm"
    afterSpan' <- obj A..:? "afterSpan"
    pure $ defMessage
      & P.beforeTerm .~ beforeTerm'
      & P.maybe'beforeSpan .~ beforeSpan'
      & P.afterTerm .~ afterTerm'
      & P.maybe'afterSpan .~ afterSpan'

instance ToJSONPB ReplacedTerm where
  toJSONPB x = object
    [ "beforeTerm" .= (x^.beforeTerm)
    , "beforeSpan" .= (x^.maybe'beforeSpan)
    , "afterTerm" .= (x^.afterTerm)
    , "afterSpan" .= (x^.maybe'afterSpan)
    ]
  toEncodingPB x = pairs
    [ "beforeTerm" .= (x^.beforeTerm)
    , "beforeSpan" .= (x^.maybe'beforeSpan)
    , "afterTerm" .= (x^.afterTerm)
    , "afterSpan" .= (x^.maybe'afterSpan)
    ]

instance FromJSON ReplacedTerm where
  parseJSON = parseJSONPB

instance ToJSON ReplacedTerm where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB MergedTerm where
  parseJSONPB = withObject "MergedTerm" $ \obj -> do
    term' <- obj .: "term"
    beforeSpan' <- obj A..:? "beforeSpan"
    afterSpan' <- obj A..:? "afterSpan"
    pure $ defMessage
      & P.term .~ term'
      & P.maybe'beforeSpan .~ beforeSpan'
      & P.maybe'afterSpan .~ afterSpan'

instance ToJSONPB MergedTerm where
  toJSONPB x = object
    [ "term" .= (x^.term)
    , "beforeSpan" .= (x^.maybe'beforeSpan)
    , "afterSpan" .= (x^.maybe'afterSpan)
    ]
  toEncodingPB x = pairs
    [ "term" .= (x^.term)
    , "beforeSpan" .= (x^.maybe'beforeSpan)
    , "afterSpan" .= (x^.maybe'afterSpan)
    ]

instance FromJSON MergedTerm where
  parseJSON = parseJSONPB

instance ToJSON MergedTerm where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB Blob where
  parseJSONPB = withObject "Blob" $ \obj -> do
    content' <- obj .: "content"
    path' <- obj .: "path"
    language' <- obj .: "language"
    pure $ defMessage
      & P.content .~ content'
      & P.path .~ path'
      & P.language .~ language'

instance ToJSONPB Blob where
  toJSONPB x = object
    [ "content" .= (x^.content)
    , "path" .= (x^.path)
    , "language" .= (x^.language)
    ]
  toEncodingPB x = pairs
    [ "content" .= (x^.content)
    , "path" .= (x^.path)
    , "language" .= (x^.language)
    ]

instance FromJSON Blob where
  parseJSON = parseJSONPB

instance ToJSON Blob where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB File where
  parseJSONPB = withObject "File" $ \obj -> do
    path' <- obj .: "path"
    language' <- obj .: "language"
    symbols' <- obj .: "symbols"
    errors' <- obj .: "errors"
    blobOid' <- obj .: "blobOid"
    pure $ defMessage
      & P.path .~ path'
      & P.language .~ language'
      & P.symbols .~ symbols'
      & P.errors .~ errors'
      & P.blobOid .~ blobOid'

instance ToJSONPB File where
  toJSONPB x = object
    [ "path" .= (x^.path)
    , "language" .= (x^.language)
    , "symbols" .= (x^.symbols)
    , "errors" .= (x^.errors)
    , "blobOid" .= (x^.blobOid)
    ]
  toEncodingPB x = pairs
    [ "path" .= (x^.path)
    , "language" .= (x^.language)
    , "symbols" .= (x^.symbols)
    , "errors" .= (x^.errors)
    , "blobOid" .= (x^.blobOid)
    ]

instance FromJSON File where
  parseJSON = parseJSONPB

instance ToJSON File where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB Symbol where
  parseJSONPB = withObject "Symbol" $ \obj -> do
    symbol' <- obj .: "symbol"
    kind' <- obj .: "kind"
    line' <- obj .: "line"
    span' <- obj A..:? "span"
    docs' <- obj A..:? "docs"
    nodeType' <- obj .: "nodeType"
    syntaxType' <- obj .: "syntaxType"
    pure $ defMessage
      & P.symbol .~ symbol'
      & P.kind .~ kind'
      & P.line .~ line'
      & P.maybe'span .~ span'
      & P.maybe'docs .~ docs'
      & P.nodeType .~ nodeType'
      & P.syntaxType .~ syntaxType'

instance ToJSONPB Symbol where
  toJSONPB x = object
    [ "symbol" .= (x^.symbol)
    , "kind" .= (x^.kind)
    , "line" .= (x^.line)
    , "span" .= (x^.maybe'span)
    , "docs" .= (x^.maybe'docs)
    , "nodeType" .= (x^.nodeType)
    , "syntaxType" .= (x^.syntaxType)
    ]
  toEncodingPB x = pairs
    [ "symbol" .= (x^.symbol)
    , "kind" .= (x^.kind)
    , "line" .= (x^.line)
    , "span" .= (x^.maybe'span)
    , "docs" .= (x^.maybe'docs)
    , "nodeType" .= (x^.nodeType)
    , "syntaxType" .= (x^.syntaxType)
    ]

instance FromJSON Symbol where
  parseJSON = parseJSONPB

instance ToJSON Symbol where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB Docstring where
  parseJSONPB = withObject "Docstring" $ \obj -> do
    docstring' <- obj .: "docstring"
    pure $ defMessage
      & P.docstring .~ docstring'

instance ToJSONPB Docstring where
  toJSONPB x = object
    [ "docstring" .= (x^.docstring)
    ]
  toEncodingPB x = pairs
    [ "docstring" .= (x^.docstring)
    ]

instance FromJSON Docstring where
  parseJSON = parseJSONPB

instance ToJSON Docstring where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB Position where
  parseJSONPB = withObject "Position" $ \obj -> do
    line' <- obj .: "line"
    column' <- obj .: "column"
    pure $ defMessage
      & P.line .~ line'
      & P.column .~ column'

instance ToJSONPB Position where
  toJSONPB x = object
    [ "line" .= (x^.line)
    , "column" .= (x^.column)
    ]
  toEncodingPB x = pairs
    [ "line" .= (x^.line)
    , "column" .= (x^.column)
    ]

instance FromJSON Position where
  parseJSON = parseJSONPB

instance ToJSON Position where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB Span where
  parseJSONPB = withObject "Span" $ \obj -> do
    start' <- obj A..:? "start"
    end' <- obj A..:? "end"
    pure $ defMessage
      & P.maybe'start .~ start'
      & P.maybe'end .~ end'

instance ToJSONPB Span where
  toJSONPB x = object
    [ "start" .= (x^.maybe'start)
    , "end" .= (x^.maybe'end)
    ]
  toEncodingPB x = pairs
    [ "start" .= (x^.maybe'start)
    , "end" .= (x^.maybe'end)
    ]

instance FromJSON Span where
  parseJSON = parseJSONPB

instance ToJSON Span where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB StackGraphFile where
  parseJSONPB = withObject "StackGraphFile" $ \obj -> do
    path' <- obj .: "path"
    language' <- obj .: "language"
    nodes' <- obj .: "nodes"
    paths' <- obj .: "paths"
    errors' <- obj .: "errors"
    pure $ defMessage
      & P.path .~ path'
      & P.language .~ language'
      & P.nodes .~ nodes'
      & P.paths .~ paths'
      & P.errors .~ errors'

instance ToJSONPB StackGraphFile where
  toJSONPB x = object
    [ "path" .= (x^.path)
    , "language" .= (x^.language)
    , "nodes" .= (x^.nodes)
    , "paths" .= (x^.paths)
    , "errors" .= (x^.errors)
    ]
  toEncodingPB x = pairs
    [ "path" .= (x^.path)
    , "language" .= (x^.language)
    , "nodes" .= (x^.nodes)
    , "paths" .= (x^.paths)
    , "errors" .= (x^.errors)
    ]

instance FromJSON StackGraphFile where
  parseJSON = parseJSONPB

instance ToJSON StackGraphFile where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB StackGraphNode where
  parseJSONPB = withObject "StackGraphNode" $ \obj -> do
    id' <- obj .: "id"
    name' <- obj .: "name"
    line' <- obj .: "line"
    span' <- obj A..:? "span"
    syntaxType' <- obj .: "syntaxType"
    nodeType' <- obj .: "nodeType"
    pure $ defMessage
      & P.id .~ id'
      & P.name .~ name'
      & P.line .~ line'
      & P.maybe'span .~ span'
      & P.syntaxType .~ syntaxType'
      & P.nodeType .~ nodeType'

instance ToJSONPB StackGraphNode where
  toJSONPB x = object
    [ "id" .= (x^.id)
    , "name" .= (x^.name)
    , "line" .= (x^.line)
    , "span" .= (x^.maybe'span)
    , "syntaxType" .= (x^.syntaxType)
    , "nodeType" .= (x^.nodeType)
    ]
  toEncodingPB x = pairs
    [ "id" .= (x^.id)
    , "name" .= (x^.name)
    , "line" .= (x^.line)
    , "span" .= (x^.maybe'span)
    , "syntaxType" .= (x^.syntaxType)
    , "nodeType" .= (x^.nodeType)
    ]

instance FromJSON StackGraphNode where
  parseJSON = parseJSONPB

instance ToJSON StackGraphNode where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB StackGraphPath where
  parseJSONPB = withObject "StackGraphPath" $ \obj -> do
    startingSymbolStack' <- obj .: "startingSymbolStack"
    startingScopeStackSize' <- obj .: "startingScopeStackSize"
    from' <- obj .: "from"
    edges' <- obj .: "edges"
    to' <- obj .: "to"
    endingScopeStack' <- obj .: "endingScopeStack"
    endingSymbolStack' <- obj .: "endingSymbolStack"
    pure $ defMessage
      & P.startingSymbolStack .~ startingSymbolStack'
      & P.startingScopeStackSize .~ startingScopeStackSize'
      & P.from .~ from'
      & P.edges .~ edges'
      & P.to .~ to'
      & P.endingScopeStack .~ endingScopeStack'
      & P.endingSymbolStack .~ endingSymbolStack'

instance ToJSONPB StackGraphPath where
  toJSONPB x = object
    [ "startingSymbolStack" .= (x^.startingSymbolStack)
    , "startingScopeStackSize" .= (x^.startingScopeStackSize)
    , "from" .= (x^.from)
    , "edges" .= (x^.edges)
    , "to" .= (x^.to)
    , "endingScopeStack" .= (x^.endingScopeStack)
    , "endingSymbolStack" .= (x^.endingSymbolStack)
    ]
  toEncodingPB x = pairs
    [ "startingSymbolStack" .= (x^.startingSymbolStack)
    , "startingScopeStackSize" .= (x^.startingScopeStackSize)
    , "from" .= (x^.from)
    , "edges" .= (x^.edges)
    , "to" .= (x^.to)
    , "endingScopeStack" .= (x^.endingScopeStack)
    , "endingSymbolStack" .= (x^.endingSymbolStack)
    ]

instance FromJSON StackGraphPath where
  parseJSON = parseJSONPB

instance ToJSON StackGraphPath where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB NodeType where
  parseJSONPB (JSONPB.String "ROOT_SCOPE") = pure ROOT_SCOPE
  parseJSONPB (JSONPB.String "JUMP_TO_SCOPE") = pure JUMP_TO_SCOPE
  parseJSONPB (JSONPB.String "EXPORTED_SCOPE") = pure EXPORTED_SCOPE
  parseJSONPB (JSONPB.String "DEFINITION") = pure DEFINITION
  parseJSONPB (JSONPB.String "REFERENCE") = pure REFERENCE
  parseJSONPB x = typeMismatch "NodeType" x

instance ToJSONPB NodeType where
  toJSONPB x _ = A.String . T.toUpper . T.pack $ show x
  toEncodingPB x _ = E.text . T.toUpper . T.pack  $ show x

instance FromJSON NodeType where
  parseJSON = parseJSONPB

instance ToJSON NodeType where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding

instance FromJSONPB SyntaxType where
  parseJSONPB (JSONPB.String "FUNCTION") = pure FUNCTION
  parseJSONPB (JSONPB.String "METHOD") = pure METHOD
  parseJSONPB (JSONPB.String "CLASS") = pure CLASS
  parseJSONPB (JSONPB.String "MODULE") = pure MODULE
  parseJSONPB (JSONPB.String "CALL") = pure CALL
  parseJSONPB (JSONPB.String "TYPE") = pure TYPE
  parseJSONPB (JSONPB.String "INTERFACE") = pure INTERFACE
  parseJSONPB (JSONPB.String "IMPLEMENTATION") = pure IMPLEMENTATION
  parseJSONPB x = typeMismatch "SyntaxType" x

instance ToJSONPB SyntaxType where
  toJSONPB x _ = A.String . T.toUpper . T.pack $ show x
  toEncodingPB x _ = E.text . T.toUpper . T.pack  $ show x

instance FromJSON SyntaxType where
  parseJSON = parseJSONPB

instance ToJSON SyntaxType where
  toJSON = toAesonValue
  toEncoding = toAesonEncoding
