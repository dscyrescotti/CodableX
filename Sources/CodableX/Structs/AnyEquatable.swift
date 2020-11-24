public struct AnyEquatable {
    public let value: Any
    public init(_ value: Any) {
        self.value = value
    }
}

extension AnyEquatable: Equatable {
    public static func == (lhs: AnyEquatable, rhs: AnyEquatable) -> Bool {
        equate(lhs.value, rhs.value)
    }
}
