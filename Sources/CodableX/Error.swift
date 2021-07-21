import Foundation

/// `CodableXError` is the custom error type of `CodableX`.
public enum CodableXError: Error {
    case mismatch(String)
    case unableToForce(String)
}

extension CodableXError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .mismatch(let type):
            return "Uable to decode data into any of the options in \(type)"
        case .unableToForce(let type):
            return "Uable to force to \(type)"
        }
    }
}
