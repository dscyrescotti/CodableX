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
    public func decode<T: Nullable, P: Optionable>(_ type: OptionalOneOf<T, P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> OptionalOneOf<T, P> {
        return try decodeIfPresent(OptionalOneOf<T, P>.self, forKey: key) ?? OptionalOneOf<T, P>(wrappedValue: T(value: nil))
    }
}
