import Foundation

extension UnkeyedDecodingContainer {
    mutating func decode(_ type: [Any].Type) throws -> [Any] {
        var elements: [Any] = []
        while !isAtEnd {
            if try decodeNil() {
                elements.append(NSNull())
            } else if let any = try? decode(Anyable<DefaultOptions>.self).wrappedValue {
                elements.append(any)
            } else if let values = try? nestedContainer(keyedBy: AnyCodingKey.self),
                let element = try? values.decode([String: Any].self) {
                elements.append(element)
            } else if var values = try? nestedUnkeyedContainer(),
                let element = try? values.decode([Any].self) {
                elements.append(element)
            }
        }
        return elements
    }
}
