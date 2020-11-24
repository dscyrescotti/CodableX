/// It is the default optional types to decode and encode value using them.
public struct DefaultOptions: Optionable {
    public static var options: [Option] = [
        .init(String.self),
        .init(Bool.self),
        .init(Int.self),
        .init(Double.self),
        .init(Float.self)
    ]
}
