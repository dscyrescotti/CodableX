/// `@Nullable` serves as the traditional `Optional` (aka ?) of `Swift`. When encoding, it is able to encode `nil` as `null` in JSON.
@propertyWrapper
public struct Nullable<T: Codable>: Codable {
    public var wrappedValue: T?
    public init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try? container.decode(T.self)
        self.wrappedValue = value
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = wrappedValue {
            try container.encode(value)
        } else {
            try container.encodeNil()
        }
    }
    public var projectedValue: T? {
        wrappedValue
    }
}
