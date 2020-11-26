import CodableX

struct OneOfArrayTest: Codable {
    @OneOfArray<AnyValue, ArrayOption> var defaultArray: [AnyValue]
}

struct DefaultTest: Codable {
    @Default var defaultInt: String
    @Default var defaultCustom: DefaultCustom
    @Default var defaultSet: Set<Int>
}

struct OneOfTest: Codable {
    @OneOf<AnyValue, DefaultOptions> var data: AnyValue
    @OneOf<AnyCustomValue, CustomOptions> var custom: AnyCustomValue
}

struct ArrayOption: Optionable {
    static var options: [Option] = [
        Option([String: Int].self)
    ]
}

struct NullableOneOfTest: Codable {
    @NullableOneOf<AnyValue, DefaultOptions> var optional: AnyValue?
}

struct CustomOptions: Optionable {
    static var options: [Option] = [
        Option(String.self),
        Option(Int.self),
        Option(Person.self)
    ]
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

struct NullTest: Codable {
    @Null var int: Int?
}

struct EquatableTest: AnyCodable, Hashable {
    let string: String
    let int: Int
}

struct ForceTest: Codable {
    @Force<ForceCustom, DefaultOptions> var force: ForceCustom
}

struct ForceCustom: ForceCodable {
    init?(_ description: String) {
        guard let value = Int.init(description) else {
            return nil
        }
        self.int = value
    }
    var description: String {
        int.description
    }
    var int: Int
}

struct CompactTest: Codable {
    @Compact var compacts: [Int]
}

struct ForceArrayTest: Codable {
    @ForceArray<Bool, DefaultOptions> var bools: [Bool]
    @ForceArray<Int, DefaultOptions> var ints: [Int]
}
