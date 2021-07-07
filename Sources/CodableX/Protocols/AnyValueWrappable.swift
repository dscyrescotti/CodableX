public protocol AnyValueWrappable { }

public extension AnyValueWrappable where Self: AnyCodable {
    var anyValue: AnyValue {
        AnyValue(value: self)
    }
}
