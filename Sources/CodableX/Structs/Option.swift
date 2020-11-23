public struct Option {
    var type: AnyCodable.Type
    public init(_ type: AnyCodable.Type) {
        self.type = type
    }
}

extension Option {
    // MARK: - Decode Helpers
    func decode(container: inout UnkeyedDecodingContainer) -> AnyCodable? {
        return type.decode(container: &container)
    }
    func decode(container: inout SingleValueDecodingContainer) -> AnyCodable? {
        return type.decode(container: &container)
    }
}
