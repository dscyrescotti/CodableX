import Foundation

public protocol AnyCodable: Codable { }

extension AnyCodable {
    public func toAnyEquatable() -> AnyEquatable {
        AnyEquatable(self)
    }
}

extension AnyCodable where Self: ForceCodable {
    static func decode() -> (Decoder) -> ForceCodable? {
        return { try? Self.init(from: $0) }
    }
}

extension AnyCodable {
    static private func typed() -> Self.Type {
        Self.self
    }
    /// It will return its pure type that conforms to `AnyCodable`.
    /// - Returns: Type that conforms to `AnyCodable`
    public func type() -> Self.Type {
        Swift.type(of: self)
    }
    static func decode(container: inout UnkeyedDecodingContainer) -> Self? {
        guard let decoded = try? container.decode(self.typed()) else {
            return nil
        }
        return decoded
    }
    static func decode(container: inout SingleValueDecodingContainer) -> Self? {
        guard let decoded = try? container.decode(self.typed()) else {
            return nil
        }
        return decoded
    }
    
    func encode(container: inout UnkeyedEncodingContainer) throws {
        try container.encode(self)
    }
    func encode(container: inout SingleValueEncodingContainer) throws {
        try container.encode(self)
    }
}
