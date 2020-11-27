import CodableX

struct OneOfArrayTest: Codable {
    @ArrayAnyable<ArrayOption> var defaultArray: [Any]
}

struct DefaultTest: Codable {
    @Defaultable var defaultInt: String
    @Defaultable var defaultCustom: DefaultCustom
    @Defaultable var defaultSet: Set<Int>
}

struct OneOfTest: Codable {
    @Anyable<DefaultOptions> var data: Any
    @Anyable<CustomOptions> var custom: Any
}

struct ArrayOption: OptionConfigurable {
    static var options: [Option] = [
        Option([String: Int].self),
        Option(Int.self),
        Option(String.self),
    ]
}

struct NullableOneOfTest: Codable {
    @OptionalAnyable<DefaultOptions> var optional: Any?
}

struct CustomOptions: OptionConfigurable {
    static var options: [Option] = [
        Option(String.self),
        Option(Int.self),
        Option(Person.self)
    ]
}

class Person: AnyCodable {
    var name: String
    init(name: String) {
        self.name = name
    }
}

struct DefaultCustom: DefaultCodable {
    init() {
        self._array = ArrayAnyable(wrappedValue: [])
    }
    @ArrayAnyable<CustomOptions> var array: [Any]
}

struct NullTest: Codable {
    @Nullable var int: Int?
}

struct EquatableTest: AnyCodable, Hashable {
    let string: String
    let int: Int
}

struct ForceTest: Codable {
    @Forcable<ForceCustom, DefaultOptions> var force: ForceCustom
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
    @Compactable var compacts: [Int]
}

struct ForceArrayTest: Codable {
    @ArrayForcable<Bool, DefaultOptions> var bools: [Bool]
    @ArrayForcable<Int, DefaultOptions> var ints: [Int]
}

struct NullableForceTest: Codable {
    @OptionalForcable<Bool, DefaultOptions> var bool: Bool?
}

struct DefaultBool: DefaultConfigurable {
    static var defaultValue: some DefaultCodable = true
}

struct DefaultInt: DefaultConfigurable {
    static var defaultValue: some DefaultCodable = 100
}

struct CustomDefaultTest: Codable {
    @CustomDefaultable<Bool, DefaultBool> var bool: Bool
    @CustomDefaultable<Int, DefaultBool> var int: Int
}
