@propertyWrapper
public struct ArrayJsonable: Codable {
    public var wrappedValue: [[String: Any]]
    public init(wrappedValue: [[String: Any]]) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements: [[String:Any]] = []
        while !container.isAtEnd {
            if let value = try? container.decode(Jsonable.self).wrappedValue {
                elements.append(value)
            } else {
                _ = try? container.decode(Empty.self)
            }
        }
        self.wrappedValue = elements
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for json in wrappedValue {
            try container.encode(json)
        }
    }
    public var projectedValue: [[String: Any]] {
        wrappedValue
    }
}
