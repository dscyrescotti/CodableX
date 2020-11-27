/// It stores any type that conforms to `AnyCodable`.
public struct Option {
    internal var type: AnyCodable.Type
    /// - Parameter type: Any type that conforms to `AnyCodable`
    public init(_ type: AnyCodable.Type) {
        self.type = type
    }
}

public extension Option {
    func decode(container: inout UnkeyedDecodingContainer) -> AnyCodable? {
        return type.decode(container: &container)
    }
    func decode(container: inout SingleValueDecodingContainer) -> AnyCodable? {
        return type.decode(container: &container)
    }
}
