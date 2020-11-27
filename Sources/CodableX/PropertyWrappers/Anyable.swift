/// It helps decoding and encoding for a value that has one of the specific types.
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
            throw DecodingError.typeMismatch(P.self, .init(codingPath: container.codingPath, debugDescription: "OneOf does not find such a kind of type in \(P.Type.self)"))
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

