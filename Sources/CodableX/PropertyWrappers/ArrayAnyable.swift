/// It helps decoding and encoding an array that has different types of elements.
@propertyWrapper
public struct ArrayAnyable<P: OptionConfigurable>: Codable {
    public var wrappedValue: [Any]
    public init(wrappedValue: [Any]) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements: [Any] = []
        while !container.isAtEnd {
            if let value = try? container.decode(Anyable<P>.self).wrappedValue {
                elements.append(value)
            } else {
                _ = try? container.decode(Empty.self)
            }
        }

        self.wrappedValue = elements
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for value in wrappedValue {
            if let anyCodable = value as? AnyCodable {
                try anyCodable.encode(container: &container)
            }
        }
    }
    public var projectedValue: [Any] {
        wrappedValue
    }
}
