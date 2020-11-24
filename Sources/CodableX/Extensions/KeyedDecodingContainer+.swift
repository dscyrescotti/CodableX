extension KeyedDecodingContainer {
    // MARK: - OneOfArray
    public func decode<T: Anyable, P: Optionable>(_ type: OneOfArray<T, P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> OneOfArray<T, P> {
        return try decodeIfPresent(OneOfArray<T, P>.self, forKey: key) ?? OneOfArray<T, P>(wrappedValue: [])
    }
    
    // MARK: - Default
    public func decode<T: DefaultCodable>(_ type: Default<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Default<T> {
        return try decodeIfPresent(Default<T>.self, forKey: key) ?? Default<T>(wrappedValue: T())
    }
    
    // MARK: - OptionalOneOf
    public func decode<T: Anyable, P: Optionable>(_ type: NullableOneOf<T, P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> NullableOneOf<T, P> {
        return try decodeIfPresent(NullableOneOf<T, P>.self, forKey: key) ?? NullableOneOf<T, P>(wrappedValue: nil)
    }
    
    // MARK: - Null
    public func decode<T: Codable>(_ type: Null<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Null<T> {
        return try decodeIfPresent(Null<T>.self, forKey: key) ?? Null<T>(wrappedValue: nil)
    }
}
