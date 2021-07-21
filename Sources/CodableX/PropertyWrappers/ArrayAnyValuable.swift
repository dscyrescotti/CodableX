/// `@ArrayAnyValuable` is helpful to decode data into the array of `AnyValue` values. If the type of the value doesn't include, it will be omitted. 
@propertyWrapper
public struct ArrayAnyValuable<P: OptionConfigurable>: Codable {
    public var wrappedValue: [AnyValue]
    
    public init(wrappedValue: [AnyValue]) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements: [AnyValue] = []
        while !container.isAtEnd {
            if let value = try? container.decode(AnyValuable<P>.self).wrappedValue {
                elements.append(value)
            } else {
                _ = try? container.decode(Empty.self)
            }
        }

        self.wrappedValue = elements
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for anyValue in wrappedValue {
            try anyValue.value.encode(container: &container)
        }
    }
    
    public var projectedValue: [AnyValue] {
        self.wrappedValue
    }
}
