// MARK: - Default
extension Int: DefaultCodable { }
extension String: DefaultCodable { }
extension Double: DefaultCodable { }
extension Bool: DefaultCodable { }
extension Float: DefaultCodable { }

// MARK: - Collection
extension Array: AnyCodable where Element: AnyCodable { }
extension Dictionary: AnyCodable where Key: Codable, Value: AnyCodable { }
extension Set: AnyCodable where Element: AnyCodable { }

// MARK: - Default Collection
extension Array: DefaultCodable where Element: AnyCodable { }
extension Dictionary: DefaultCodable where Key: Codable, Value: AnyCodable { }
extension Set: DefaultCodable where Element: AnyCodable { }
