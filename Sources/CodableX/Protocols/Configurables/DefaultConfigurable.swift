/// `DefaultConfigurable`is useful when you want to use different custom default values instead of the one that `CodableX`supports.
public protocol DefaultConfigurable where T: DefaultCodable {
    associatedtype T
    static var defaultValue: T { get }
}

public extension DefaultConfigurable {
    static var defaultValue: T {
        T.init()
    }
}
