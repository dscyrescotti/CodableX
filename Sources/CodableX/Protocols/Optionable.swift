public protocol Optionable {
    static var options: [Option] { get set }
}

extension Optionable {
    public static var options: [Option] { [] }
}
