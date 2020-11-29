/// `@Defaultable` provides the default value when the coding key is not found or the value is missing. For `Swift` built-in types, it will use the default `init()` method. For your custom structs or classes, you must make them conform to `DefaultCodable` and set the default value.
@propertyWrapper
public struct Defaultable<T: DefaultCodable>: Codable {
    public var wrappedValue: T = T()
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(T.self) {
            self.wrappedValue = value
        } else {
            self.wrappedValue = T()
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
    public var projectedValue: T {
        wrappedValue
    }
}
