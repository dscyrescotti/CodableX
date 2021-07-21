/// `@ArrayAnyable` is helpful to decode data into the array of `Any` values. If the type of the value doesn't include, it will be omitted. 
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
