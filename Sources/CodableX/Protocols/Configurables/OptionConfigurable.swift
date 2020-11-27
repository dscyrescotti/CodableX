public protocol OptionConfigurable {
    static var options: [Option] { get set }
}

public extension OptionConfigurable {
    static var options: [Option] { [] }
}
