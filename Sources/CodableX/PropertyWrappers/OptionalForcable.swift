/// `@OptionalAnyable` should be used for the optional `Forcable` value. If the coding key is not found or the value is missing, it will be assigned nil.
@propertyWrapper
public struct OptionalForcable<T: ForceCodable, P: OptionConfigurable>: Codable {
    public var wrappedValue: T?
    public init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        guard let value = try? container.decode(Forcable<T, P>.self).wrappedValue else {
            return
        }
        wrappedValue = value
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = wrappedValue {
            try value.encode(container: &container)
        } else {
            try container.encodeNil()
        }
    }
    public var projectedValue: T? {
        wrappedValue
    }
}
