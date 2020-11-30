import Foundation

/// `@Jsonable` is handy to decode data into JSON object structure using dictionary of `Swift`.
@propertyWrapper
public struct Jsonable: Codable {
    public var wrappedValue: Any
    public init(wrappedValue: Any) {
        self.wrappedValue = wrappedValue
    }
    public init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer(), let value = try? container.decode(Anyable<DefaultOptions>.self).wrappedValue {
            self.wrappedValue = value
            return
        }
        if var container = try? decoder.unkeyedContainer() {
            var elements: [Any] = []
            while !container.isAtEnd {
                if let value = try? container.decode(Jsonable.self).wrappedValue {
                    elements.append(value)
                }
            }
            self.wrappedValue = elements
            return
        }
        if let container = try? decoder.container(keyedBy: AnyCodingKey.self), let value = try? container.decode([String: Any].self) {
            self.wrappedValue = value
            return
        }
        self.wrappedValue = NSNull()
    }
    public func encode(to encoder: Encoder) throws {
        if let any = wrappedValue as? AnyCodable {
            try any.encode(to: encoder)
            return
        }
        if  let array = wrappedValue as? [Any] {
            var container = encoder.unkeyedContainer()
            try container.encode(array)
            return
        }
        if let dict = wrappedValue as? [String: Any] {
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(dict)
            return
        }
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
