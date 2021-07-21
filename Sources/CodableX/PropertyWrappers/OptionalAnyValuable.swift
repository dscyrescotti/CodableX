/// `@OptionalAnyValuable` should be used for the optional of `AnyValue` value. If the coding key is not found or the value is missing, it will be assigned nil.
@propertyWrapper
public struct OptionalAnyValuable<P: OptionConfigurable>: Codable {
    public var wrappedValue: AnyValue?
    public init(wrappedValue: AnyValue?) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        guard let value = try? container.decode(AnyValuable<P>.self).wrappedValue else {
            return
        }
        wrappedValue = value
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let anyValue = wrappedValue {
            try anyValue.value.encode(container: &container)
        } else {
            try container.encodeNil()
        }
    }
    public var projectedValue: AnyValue? {
        wrappedValue
    }
}

