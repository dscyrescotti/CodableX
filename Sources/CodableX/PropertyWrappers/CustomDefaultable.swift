/// `@CustomDefaultable` is literally `@Defaultable` that allows you to customize the default value of `Swift` built-in types. You need to pre-configure the default value.
@propertyWrapper
public struct CustomDefaultable<T: DefaultCodable, D: DefaultConfigurable>: Codable {
    public var wrappedValue: T = T()
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(T.self) {
            self.wrappedValue = value
        } else {
            self.wrappedValue = D.defaultValue as? T ?? T.init()
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
