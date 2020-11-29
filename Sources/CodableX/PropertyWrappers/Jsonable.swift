/// `@Jsonable` decodes all json data as the dictionary of `Any` with key `String`. It is flexible and handy to decode because you don’t need to define structs or classes for it.
@propertyWrapper
public struct Jsonable: Codable {
    public var wrappedValue: [String: Any]
    public init(wrappedValue: [String: Any]) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnyCodingKey.self)
        self.wrappedValue = try container.decode([String: Any].self)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AnyCodingKey.self)
        try container.encode(wrappedValue)
    }
    public var projectedValue: [String: Any] {
        wrappedValue
    }
}
