/// It is the default optional types to decode and encode value using them.
public struct DefaultOptions: Optionable {
    public static var options: [Option] = [
        .init(Int.self),
        .init(String.self),
        .init(Bool.self),
        .init(Double.self),
        .init(Float.self)
    ]
    
    let int = Option(Int.self)
    let string = Option(String.self)
    let bool = Option(Bool.self)
    let double = Option(Double.self)
    let float = Optional(Float.self)
    public init() { }
}
