/// It helps decoding and encoding for a value that has one of the specific types or `nil`.
@propertyWrapper
public struct OptionalAnyable<P: OptionConfigurable>: Codable {
    public var wrappedValue: Any?
    public init(wrappedValue: Any?) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        guard let value = try? container.decode(Anyable<P>.self).wrappedValue else {
            return
        }
        wrappedValue = value
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = wrappedValue as? AnyCodable {
            try value.encode(container: &container)
        } else {
            try container.encodeNil()
        }
    }
    public var projectedValue: Any? {
        wrappedValue
    }
}
