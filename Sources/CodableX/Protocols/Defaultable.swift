public protocol Defaultable where T: DefaultCodable {
    associatedtype T
    static var defaultValue: T { get }
}

public extension Defaultable {
    static var defaultValue: T {
        T.init()
    }
}
