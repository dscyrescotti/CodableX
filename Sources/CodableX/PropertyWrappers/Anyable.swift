/// `@Anyable` is designed to decode data into `Any` value when it matches one of the types that you pre-configured. It will throw an error if its type is out of the pre-specified types.
@propertyWrapper
public struct Anyable<P: OptionConfigurable>: Codable {
    public var wrappedValue: Any
    public init(wrappedValue: Any) {
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
            wrappedValue = value
        } else {
            throw CodableXError.mismatch("\(P.self)")
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        guard let value = wrappedValue as? AnyCodable else {
            return
        }
        try value.encode(container: &container)
    }
    public var projectedValue: Any {
        wrappedValue
    }
}
