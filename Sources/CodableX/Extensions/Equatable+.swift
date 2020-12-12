extension Equatable {
    static func equate(_ lhs: Any, _ rhs: Any) -> Bool {
        guard lhs is AnyHashable else {
            debugPrint("Warning: \(Swift.type(of: lhs)) doesn't conform to Hashable. Comparing each other always return `false`.")
            return false
        }
        guard rhs is AnyHashable else {
            debugPrint("Warning: \(Swift.type(of: lhs)) doesn't conform to Hashable. Comparing each other always return `false`.")
            return false
        }
        print((lhs as! AnyHashable).hashValue, (rhs as! AnyHashable).hashValue)
        return (lhs as! AnyHashable) == (rhs as! AnyHashable)
      }
}
