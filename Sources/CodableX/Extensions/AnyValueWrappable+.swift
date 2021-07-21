extension Int: AnyValueWrappable { }
extension String: AnyValueWrappable { }
extension Bool: AnyValueWrappable { }
extension Double: AnyValueWrappable { }
extension Float: AnyValueWrappable { }

extension Array: AnyValueWrappable where Element: AnyValueWrappable & AnyCodable {
    var arrayOfAnyValue: [AnyValue] {
        self.map { $0.anyValue }
    }
}
extension Array where Element == Any {
    var anyValues: [AnyValue] {
        self.map { AnyValue(any: $0) }
    }
}
extension Dictionary: AnyValueWrappable { }
