import Foundation

extension UnkeyedEncodingContainer {
    mutating func encode(_ value: [Any]) throws {
        for v in value {
            if v is NSNull {
                try encodeNil()
            } else {
                try Jsonable(wrappedValue: v).encode(to: self.superEncoder())
            }
        }
    }
}
