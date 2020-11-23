public struct DefaultOptions: Optionable {
    let int = Option(Int.self)
    let string = Option(String.self)
    let bool = Option(Bool.self)
    let double = Option(Double.self)
    public init() { }
}
