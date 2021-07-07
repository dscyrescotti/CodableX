public struct AnyValue {
    public var value: AnyCodable
    
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
}
