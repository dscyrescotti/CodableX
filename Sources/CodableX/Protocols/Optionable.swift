import Foundation

public protocol Optionable {
    init()
}

extension Optionable {
    func properties() throws -> [String: Option] {
        var result: [String: Option] = [:]
        let mirror = Mirror(reflecting: self)
        guard let style = mirror.displayStyle, style == .struct else {
            throw NSError(domain: "hris.to", code: 777, userInfo: nil)
        }
        for child in mirror.children {
            guard let label = child.label, let value = child.value as? Option else {
                continue
            }
            result[label] = value
        }
        return result
    }
}
