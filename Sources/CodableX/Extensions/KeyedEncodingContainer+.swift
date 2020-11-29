import Foundation

extension KeyedEncodingContainer {
    mutating func encode(_ value: [String: Any], forKey key: KeyedEncodingContainer<K>.Key) throws {
        var container = nestedContainer(keyedBy: AnyCodingKey.self, forKey: key)
        try container.encode(value)
    }
    mutating func encode(_ value: [Any], forKey key: KeyedEncodingContainer<K>.Key) throws {
        var container = nestedUnkeyedContainer(forKey: key)
        try container.encode(value)
    }
}

extension KeyedEncodingContainer where K == AnyCodingKey {
    mutating func encode(_ value: [String: Any]) throws {
        for (k, v) in value {
            let key = AnyCodingKey(stringValue: k)!
            switch v {
            case is NSNull:
                try encodeNil(forKey: key)
            case let string as String:
                try encode(string, forKey: key)
            case let int as Int:
                try encode(int, forKey: key)
            case let bool as Bool:
                try encode(bool, forKey: key)
            case let double as Double:
                try encode(double, forKey: key)
            case let dict as [String: Any]:
                try encode(dict, forKey: key)
            case let array as [Any]:
                try encode(array, forKey: key)
            default:
                continue
            }
        }
    }
}

extension UnkeyedEncodingContainer {
    mutating func encode(_ value: [Any]) throws {
        for v in value {
            switch v {
            case is NSNull:
                try encodeNil()
            case let string as String:
                try encode(string)
            case let int as Int:
                try encode(int)
            case let bool as Bool:
                try encode(bool)
            case let double as Double:
                try encode(double)
            case let dict as [String: Any]:
                try encode(dict)
            case let array as [Any]:
                var values = nestedUnkeyedContainer()
                try values.encode(array)
            default:
                continue
            }
        }
    }

    mutating func encode(_ value: [String: Any]) throws {
        var container = self.nestedContainer(keyedBy: AnyCodingKey.self)
        try container.encode(value)
    }
}
