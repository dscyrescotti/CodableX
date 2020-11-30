import CodableX
import Foundation

func decode<T: Codable>(_ type: T.Type, _ str: String, callback: @escaping (T) -> Void) {
    guard let data = str.data(using: .utf8) else {
        fatalError("Invalid json data")
    }
    guard let decoded = try? JSONDecoder().decode(type, from: data) else {
        fatalError("Cannot decode properly")
    }
    callback(decoded)
}

func encode<T: Codable>(_ data: T, callback: @escaping (T, Data) -> Void) {
    guard let encoded = try? JSONEncoder().encode(data) else {
        fatalError("Cannot encode properly")
    }
    callback(data, encoded)
}

func decode<T: Codable>(_ type: T.Type, _ data: Data) -> T? {
    return try? JSONDecoder().decode(type, from: data)
}
