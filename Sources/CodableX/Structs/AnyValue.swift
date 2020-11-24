/// It is the defult `Anyable` struct to store different types of values that conform to `AnyCodable`.
public struct AnyValue: Anyable {
    public var value: AnyCodable
    public func type() -> AnyCodable.Type {
        value.type()
    }
    public init(value: AnyCodable) {
        self.value = value
    }
}

extension AnyValue: Equatable {
    public static func == (lhs: AnyValue, rhs: AnyValue) -> Bool {
        equate(lhs.value, rhs.value)
    }
}
