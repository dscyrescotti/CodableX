/// It is a convenience protocol to helps decoding and encoding different types of values that conforms to `AnyCodable`. If not find one of the given types, it will set `nil`.
public protocol Nullable {
    var value: AnyCodable? { get set }
    init(value: AnyCodable?)
}
