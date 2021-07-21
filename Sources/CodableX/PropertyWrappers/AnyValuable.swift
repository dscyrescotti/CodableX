///`@AnyValuable` is similar to `@Anyable` but it deocdes data into `AnyValue` which stores decoded value in it instead of turning into `Any`. It provides the easy way to access value.
@propertyWrapper
public struct AnyValuable<P: OptionConfigurable>: Codable {
    public var wrappedValue: AnyValue
    public init(wrappedValue: AnyValue) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        var container = try decoder.singleValueContainer()
        var anyCodable: AnyCodable?
        for option in P.options {
            if let value = option.decode(container: &container) {
                anyCodable = value
                break
            }
        }
        if let value = anyCodable {
            wrappedValue = AnyValue(value: value)
        } else {
            throw CodableXError.mismatch("\(P.self)")
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try wrappedValue.value.encode(container: &container)
    }
    public var projectedValue: AnyValue {
        wrappedValue
    }
}
