@propertyWrapper
public struct Compact<T: AnyCodable>: Codable {
    public var wrappedValue: [T]
    public init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements: [T] = []
        while !container.isAtEnd {
            if let value = T.decode(container: &container) {
                elements.append(value)
            } else {
                _ = try? container.decode(Empty.self)
            }
        }
        self.wrappedValue = elements
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for v in wrappedValue {
            try? v.encode(container: &container)
        }
    }
}
