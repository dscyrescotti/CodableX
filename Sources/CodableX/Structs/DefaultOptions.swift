/// `DefaultOptions` is the default optional types to decode and encode value using them.
public struct DefaultOptions: OptionConfigurable {
    public static var options: [Option] = [
        .init(Int.self),
        .init(String.self),
        .init(Bool.self),
        .init(Double.self),
    ]
}
