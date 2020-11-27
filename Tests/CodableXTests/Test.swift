import CodableX

struct OneOfArrayTest: Codable {
    @OneOfArray<ArrayOption> var defaultArray: [Any]
}

struct DefaultTest: Codable {
    @Default var defaultInt: String
    @Default var defaultCustom: DefaultCustom
    @Default var defaultSet: Set<Int>
}

struct OneOfTest: Codable {
    @OneOf<DefaultOptions> var data: Any
    @OneOf<CustomOptions> var custom: Any
}

struct ArrayOption: Optionable {
    static var options: [Option] = [
        Option([String: Int].self),
        Option(Int.self),
        Option(String.self),
    ]
}

struct NullableOneOfTest: Codable {
    @NullableOneOf<DefaultOptions> var optional: Any?
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
    @OneOfArray<CustomOptions> var array: [Any]
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

struct NullableForceTest: Codable {
    @NullableForce<Bool, DefaultOptions> var bool: Bool?
}

struct DefaultBool: Defaultable {
    static var defaultValue: some DefaultCodable = true
}

struct DefaultInt: Defaultable {
    static var defaultValue: some DefaultCodable = 100
}

struct CustomDefaultTest: Codable {
    @CustomDefault<Bool, DefaultBool> var bool: Bool
    @CustomDefault<Int, DefaultBool> var int: Int
}
