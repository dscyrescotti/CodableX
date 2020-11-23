import CodableX

struct OneOfArrayTest: Codable {
    @OneOfArray<AnyValue, ArrayOption> var defaultArray: [AnyValue]
}

struct DefaultTest: Codable {
    @Default var defaultInt: Int
    @Default var defaultCustom: DefaultCustom
    @Default var defaultSet: Set<Int>
}

struct OneOfTest: Codable {
    @OneOf<AnyValue, DefaultOptions> var data: AnyValue
    @OneOf<AnyCustomValue, CustomOptions> var custom: AnyCustomValue
}

struct ArrayOption: Optionable {
    let dictionary = Option([String: Int].self)
}

struct OptionalOneOfTest: Codable {
    @OptionalOneOf<OptionalValue, DefaultOptions> var optional: OptionalValue
}

struct CustomOptions: Optionable {
    let string = Option(String.self)
    let int = Option(Int.self)
    let person = Option(Person.self)
}

struct AnyCustomValue: Anyable {
    var value: AnyCodable
    func asInt() -> Int? {
        value as? Int
    }
    func asString() -> String? {
        value as? String
    }
    func asPerson() -> Person? {
        value as? Person
    }
}

class Person: AnyCodable {
    var name: String
    init(name: String) {
        self.name = name
    }
}

struct DefaultCustom: DefaultCodable {
    init() {
        self._array = OneOfArray(wrappedValue: [])
    }
    @OneOfArray<AnyValue, CustomOptions> var array: [AnyValue]
}
