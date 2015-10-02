/// A language of diffing algorithms.
enum Algorithm<Recur, A> {
	/// The type of `Term`s over which `Algorithm`s operate.
	typealias Term = Fix<A>

	/// The type of `Diff`s which `Algorithm`s produce.
	typealias Diff = Free<A, Patch<A>>

	/// Indicates that diffing should recur into the enclosed `Term`.
	///
	/// When run, the enclosed function will be applied to the resulting `Diff`.
	case Recursive(Term, Diff -> Recur)
}
