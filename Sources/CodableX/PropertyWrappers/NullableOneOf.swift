/// It helps decoding and encoding for a value that has one of the specific types or `nil`.
@propertyWrapper
public struct NullableOneOf<T: Anyable, P: Optionable>: Codable {
    public var wrappedValue: T?
    public init(wrappedValue: T?) {
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
        guard let any = anyCodable else {
            return
        }
        wrappedValue = T(value: any)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = wrappedValue?.value {
            try value.encode(container: &container)
        } else {
            try container.encodeNil()
        }
    }
    public var projectedValue: AnyCodable? {
        wrappedValue?.value
    }
}
