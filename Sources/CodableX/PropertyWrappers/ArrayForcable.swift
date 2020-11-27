@propertyWrapper
public struct ArrayForcable<T: ForceCodable, P: OptionConfigurable>: Codable {
    public var wrappedValue: [T]
    public init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements: [T] = []
        while !container.isAtEnd {
            if let value = try? container.decode(Forcable<T, P>.self).wrappedValue {
                elements.append(value)
            } else {
                _ = try? container.decode(Empty.self)
            }
        }
        self.wrappedValue = elements
    }
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
    public var projectedValue: [T] {
        wrappedValue
    }
}