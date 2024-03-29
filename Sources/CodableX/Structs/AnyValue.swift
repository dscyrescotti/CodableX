public struct AnyValue: Equatable {
    public static func == (lhs: AnyValue, rhs: AnyValue) -> Bool {
        lhs.value.toAnyEquatable() == rhs.value.toAnyEquatable()
    }
    
    public var value: AnyCodable
    
    public init(value: AnyCodable) {
        self.value = value
    }
    
    public init(any: Any) {
        guard let value = any as? AnyCodable else {
            fatalError("The value of `AnyValue` needs to conform to `AnyCodable`.")
        }
        self.value = value
    }
    
    public var type: AnyCodable.Type {
        value.type()
    }
}

public extension AnyValue {
    var string: String? {
        return value as? String
    }
    
    var int: Int? {
        return value as? Int
    }
    
    var double: Double? {
        if let int = self.int {
            return Double(int)
        }
        return value as? Double
    }
    
    var bool: Bool? {
        return value as? Bool
    }
    
    var float: Float? {
        if let int = self.int {
            return Float(int)
        }
        return value as? Float
    }
    
    func array<T: AnyCodable>(_ : T.Type) -> [T]? {
        return value as? [T]
    }
    
    func dict<K: AnyCodable, T: AnyCodable>(_ : K.Type, _ : T.Type) -> [K: T]? {
        return value as? [K: T]
    }
}
