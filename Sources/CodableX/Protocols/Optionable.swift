public protocol Optionable {
    static var options: [Option] { get set }
}

public extension Optionable {
    static var options: [Option] { [] }
}
