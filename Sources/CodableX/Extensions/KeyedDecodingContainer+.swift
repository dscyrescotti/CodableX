extension KeyedDecodingContainer {
    // MARK: - OneOfArray
    public func decode<T: Anyable, P: Optionable>(_ type: OneOfArray<T, P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> OneOfArray<T, P> {
        return try decodeIfPresent(OneOfArray<T, P>.self, forKey: key) ?? OneOfArray<T, P>(wrappedValue: [])
    }
    
    // MARK: - Default
    public func decode<T: DefaultCodable>(_ type: Default<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Default<T> {
        return try decodeIfPresent(Default<T>.self, forKey: key) ?? Default<T>(wrappedValue: T())
    }
    
    // MARK: - NullableOneOf
    public func decode<T: Anyable, P: Optionable>(_ type: NullableOneOf<T, P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> NullableOneOf<T, P> {
        return try decodeIfPresent(NullableOneOf<T, P>.self, forKey: key) ?? NullableOneOf<T, P>(wrappedValue: nil)
    }
    
    // MARK: - Null
    public func decode<T: Codable>(_ type: Null<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Null<T> {
        return try decodeIfPresent(Null<T>.self, forKey: key) ?? Null<T>(wrappedValue: nil)
    }
    
    // MARK: - Compact
    public func decode<T: AnyCodable>(_ type: Compact<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Compact<T> {
        return try decodeIfPresent(Compact<T>.self, forKey: key) ?? Compact<T>(wrappedValue: [])
    }
    
    // MARK: - ForceArray
    public func decode<T: ForceCodable, P: Optionable>(_ type: ForceArray<T, P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> ForceArray<T, P> {
        return try decodeIfPresent(ForceArray<T, P>.self, forKey: key) ?? ForceArray<T, P>(wrappedValue: [])
    }
    
    // MARK: - NullableForce
    public func decode<T: ForceCodable, P: Optionable>(_ type: NullableForce<T, P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> NullableForce<T, P> {
        return try decodeIfPresent(NullableForce<T, P>.self, forKey: key) ?? NullableForce<T, P>(wrappedValue: nil)
    }
    
    // MARK: - CustomDefaul
    public func decode<T: DefaultCodable, D: Defaultable>(_ type: CustomDefault<T, D>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> CustomDefault<T, D> {
        return try decodeIfPresent(CustomDefault<T, D>.self, forKey: key) ?? CustomDefault<T, D>(wrappedValue: D.defaultValue as? T ?? T())
    }
}
