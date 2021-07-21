import Foundation

extension KeyedDecodingContainer {
    // MARK: - OneOfArray
    public func decode<P: OptionConfigurable>(_ type: ArrayAnyable<P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> ArrayAnyable<P> {
        return try decodeIfPresent(ArrayAnyable<P>.self, forKey: key) ?? ArrayAnyable<P>(wrappedValue: [])
    }
    
    // MARK: - Anyable
    public func decode<P: OptionConfigurable>(_ type: Anyable<P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Anyable<P> {
        guard let value = try? decodeIfPresent(Anyable<P>.self, forKey: key) else {
            throw CodableXError.mismatch("\(P.self)")
        }
        return value
    }
    
    // MARK: - AnyValuable
    public func decode<P: OptionConfigurable>(_ type: AnyValuable<P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> AnyValuable<P> {
        guard let value = try? decodeIfPresent(AnyValuable<P>.self, forKey: key) else {
            throw CodableXError.mismatch("\(P.self)")
        }
        return value
    }
    
    // MARK: - Default
    public func decode<T: DefaultCodable>(_ type: Defaultable<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Defaultable<T> {
        return try decodeIfPresent(Defaultable<T>.self, forKey: key) ?? Defaultable<T>(wrappedValue: T())
    }
    
    // MARK: - NullableOneOf
    public func decode<P: OptionConfigurable>(_ type: OptionalAnyable<P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> OptionalAnyable<P> {
        return try decodeIfPresent(OptionalAnyable<P>.self, forKey: key) ?? OptionalAnyable<P>(wrappedValue: nil)
    }
    
    // MARK: - Null
    public func decode<T: Codable>(_ type: Nullable<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Nullable<T> {
        return try decodeIfPresent(Nullable<T>.self, forKey: key) ?? Nullable<T>(wrappedValue: nil)
    }
    
    // MARK: - Compact
    public func decode<T: AnyCodable>(_ type: Compactable<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Compactable<T> {
        return try decodeIfPresent(Compactable<T>.self, forKey: key) ?? Compactable<T>(wrappedValue: [])
    }
    
    // MARK: - ForceArray
    public func decode<T: ForceCodable, P: OptionConfigurable>(_ type: ArrayForcable<T, P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> ArrayForcable<T, P> {
        return try decodeIfPresent(ArrayForcable<T, P>.self, forKey: key) ?? ArrayForcable<T, P>(wrappedValue: [])
    }
    
    // MARK: - NullableForce
    public func decode<T: ForceCodable, P: OptionConfigurable>(_ type: OptionalForcable<T, P>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> OptionalForcable<T, P> {
        return try decodeIfPresent(OptionalForcable<T, P>.self, forKey: key) ?? OptionalForcable<T, P>(wrappedValue: nil)
    }
    
    // MARK: - CustomDefault
    public func decode<T: DefaultCodable, D: DefaultConfigurable>(_ type: CustomDefaultable<T, D>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> CustomDefaultable<T, D> {
        return try decodeIfPresent(CustomDefaultable<T, D>.self, forKey: key) ?? CustomDefaultable<T, D>(wrappedValue: D.defaultValue as? T ?? T())
    }
    
    func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        var dictionary: [String: Any] = [:]
        for key in allKeys {
            if let any = try? decode(Jsonable.self, forKey: key).wrappedValue {
                dictionary[key.stringValue] = any
            } else {
                dictionary[key.stringValue] = NSNull()
            }
        }
        return dictionary
    }
}
