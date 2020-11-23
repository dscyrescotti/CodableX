public protocol Anyable {
    var value: AnyCodable { get set }
    init(value: AnyCodable)
}
