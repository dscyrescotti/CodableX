/// `OptionalConfigurable`is to pre-define the types that you want to try to decode and encode.
public protocol OptionConfigurable {
    static var options: [Option] { get set }
}

public extension OptionConfigurable {
    static var options: [Option] { [] }
}
