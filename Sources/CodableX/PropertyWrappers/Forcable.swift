import Foundation

/// `@Forcable` is handy to force the value to be the specific type that you set when it decodes. If it fails to force, it will end with throwing an error.
@propertyWrapper
public struct Forcable<T: ForceCodable, P: OptionConfigurable>: Codable {
    private var type: ForceCodable.Type
    public var wrappedValue: T
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.type = T.self
    }
    public init(from decoder: Decoder) throws {
        do {
            wrappedValue = try T.init(from: decoder)
            type = T.self
        } catch (let error) {
            func decodeBoolFromNSNumber() -> (Decoder) -> ForceCodable? {
                return { (try? Int.init(from: $0)).flatMap { Bool(exactly: NSNumber(value: $0)) } }
            }
            let types = (T.self == Bool.self ? [decodeBoolFromNSNumber()] : []) + P.options.compactMap {
                ($0.type as? ForceCodable.Type)?.decode()
            }
            guard let rawValue = types.lazy.compactMap({ $0(decoder) }).first, let value = T.init("\(rawValue)") else { throw error }
            self.wrappedValue = value
            self.type = Swift.type(of: rawValue)
        }
    }
    public func encode(to encoder: Encoder) throws {
        let string = String(describing: wrappedValue)
        guard let original = type.init(string) else {
            throw CodableXError.unableToForce("\(type)")
        }
        try original.encode(to: encoder)
    }
    public var projectedValue: T {
        wrappedValue
    }
}
