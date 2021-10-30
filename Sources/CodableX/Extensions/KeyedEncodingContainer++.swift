import Foundation

extension KeyedEncodingContainer where K == AnyCodingKey {
    mutating func encode(_ value: [String: Any]) throws {
        for (k, v) in value {
            let key = AnyCodingKey(stringValue: k)!
            if v is NSNull {
                try encodeNil(forKey: key)
            } else {
                try Jsonable(wrappedValue: v).encode(to: self.superEncoder(forKey: key))
            }
        }
    }
}
