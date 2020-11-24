/// It helps decoding and encoding an array that has different types of elements.
@propertyWrapper
public struct OneOfArray<T: Anyable, P: Optionable>: Codable {
    public var wrappedValue: [T]
    public init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements: [T] = []
        guard let options = try? P().properties() else {
            fatalError()
        }
        while !container.isAtEnd {
            var anyCodable: AnyCodable?
            for option in options {
                if let value = option.value.decode(container: &container) {
                    anyCodable = value
                    break
                }
            }
            if let value = anyCodable {
                elements.append(T(value: value))
            } else {
                _ = try? container.decode(Empty.self)
            }
        }

        self.wrappedValue = elements
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for v in wrappedValue {
            try? v.value.encode(container: &container)
        }
    }
    public var projectedValue: [AnyCodable] {
        wrappedValue.map { $0.value }
    }
}
