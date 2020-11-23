/// It is a convenience protocol to helps decoding and encoding different types of values that conforms to `AnyCodable`.
public protocol Anyable {
    var value: AnyCodable { get set }
    init(value: AnyCodable)
}
