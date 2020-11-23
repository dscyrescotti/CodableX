/// It is the defult `Nullable` struct to store different types of values that conform to `AnyCodable` or `nil`.
public struct OptionalValue: Nullable {
    public var value: AnyCodable?
    public func type() -> AnyCodable.Type? {
        value?.type()
    }
    public init(value: AnyCodable?) {
        self.value = value
    }
}
