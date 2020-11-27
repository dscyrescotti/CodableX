public protocol DefaultConfigurable where T: DefaultCodable {
    associatedtype T
    static var defaultValue: T { get }
}

public extension DefaultConfigurable {
    static var defaultValue: T {
        T.init()
    }
}
