import CodableX

struct OptionalOneOfTest: Codable {
    @OptionalOneOf<OptionalValue, DefaultOptions> var optional: OptionalValue
}
