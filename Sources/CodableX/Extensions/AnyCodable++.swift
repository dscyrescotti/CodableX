// MARK: - Default
extension Int: AnyCodable { }
extension String: AnyCodable { }
extension Double: AnyCodable { }
extension Bool: AnyCodable { }
extension Float: AnyCodable { }

// MARK: - Collection
extension Array: AnyCodable where Element: AnyCodable { }
extension Dictionary: AnyCodable where Key: Codable, Value: AnyCodable { }
extension Set: AnyCodable where Element: AnyCodable { }
