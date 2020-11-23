import CodableX

struct OneOfArrayTest: Codable {
    @OneOfArray<AnyValue, ArrayOption> var defaultArray: [AnyValue]
}

struct ArrayOption: Optionable {
    let dictionary = Option([String: Int].self)
}
