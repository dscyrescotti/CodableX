import CodableX

struct OneOfTest: Codable {
    @OneOf<AnyValue, DefaultOptions> var data: AnyValue
    @OneOf<AnyCustomValue, CustomOptions> var custom: AnyCustomValue
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
