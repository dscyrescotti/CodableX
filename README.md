# CodableX
__CodableX__ provides the property wrappers that are pretty handy to decode and encode structs or classes as you desire without implementing your custom codable structs or classes from scratch.

## Installation

### Swift Package Manager
Add it as a dependency within your `Package.swift`,
```swift
dependencies: [
    .package(url: "https://github.com/dscyrescotti/CodableX.git", from: "0.1.0")
]
```

Currently, __CodableX__ is able to be installed via only __Swift Package Manager__.

## @Anyable
`@Anyable` is designed to decode and encode any value that matches one of the types that you pre-configure. It is very handy when the value of API response will be sure one of the values that API sends.

### Usage
Using the default options of __CodableX__.
```swift
struct AnyValue: Codable {
    @Anyable<DefaultOptions> var value: Any // Int, String, Bool or Double
}
let data = #"{ "value": 1 }"#.data(using: .utf8)!
let decoded = try JSONDecoder().decode(AnyValue.self, from: data)
print(decoded) // AnyValue(value: 1)
```
___Note: `DefaultOptions` only supports for `Int`, `String`, `Bool` and `Double`.___

Using the custom options.
```swift
struct Custom: AnyCodable {
    let value: String
}

struct CustomOptions: OptionConfigurable {
    static var options: [Option] = [
        .init(Int.self),
        .init(Custom.self),
        // add more
    ]
}

struct AnyValue: Codable {
    @Anyable<CustomOptions> var value: Any // Int, Custom or types you specify
}
```
___Note: All the options of structs or classes must conform to `AnyCodable`.___

For the array of `Anyable` and the optional `Anyable`, you can use __`@ArrayAnyable`__ and __`@OptionalAnyable`__.

## @Forcable
_All credits to __[BetterCodable](https://github.com/marksands/BetterCodable)__.

`@Forcable` is useful to force the value to be the specific type that you set when it decodes.

### Usage
```swift
struct ForceValue: Codable {
    @Forcable<Bool, DefaultOptions> var value: Bool
}
let data = #"{ "value": "true" }"#.data(using: .utf8)!
let decoded = try JSONDecoder().decode(ForceValue.self, from: data)
print(decoded) // ForceValue(value: true)
```
It allows you to customize the list of options just like `@Anyable`. It will find the type that match the data from API response from your list and then force to a specific type that you want.
For the array of `Forcable` and the optional `Forcable`, you can use __`@ArrayForcable`__ and __`@OptionalForcable`__.

## @Nullable
`@Nullable` serves as the traditional `Optional` (aka ?) of `Swift`. When encoding, it is able to encode `nil` as `null` in JSON.

### Usage
```swift
struct NullValue: Codable {
    @Nullable var value: Int?
}
let data = #"{ "value": null }"#.data(using: .utf8)!
let decoded = try JSONDecoder().decode(NullValue.self, from: data)
print(decoded) // NullValue(value: nil)
```

## @Defaultable
`@Defaultable` provides the default value when the coding key is not found or the value is missing.

### Usage
For `Swift` built-in types, it will use the default `init()` method. For your custom structs or classes, you must make them conform to `DefaultCodable` and set the default value.
```swift
struct DefaultValue: Codable {
    @Defaultable var value: String
}
let data = #"{ "value": null }"#.data(using: .utf8)!
let decoded = try JSONDecoder().decode(DefaultValue.self, from: data)
print(decoded) // DefaultValue(value: "")
```
If you want different default values of the same struct or class, or you need the custom default value for built-in types, __`@CustomDefaultable`__ will solve it.
```swift
struct CustomDefault: DefaultConfigurable {
    static var defaultValue: String = "dope"
}

struct DefaultValue: Codable {
    @CustomDefaultable<String, CustomDefault> var value: String
}
```

## @Compactable
`@Compactable` is designed to decode the array of optional values and store values that are not null. Its name is come from `compactMap(_:)` of Swift because it removes null and invalid values from array.

### Usage
```swift
struct CompactValue: Codable {
    @Compactable var array: [Int]
}
```

## @Jsonable
`@Jsonable` is handy to decode data into JSON object structure using dictionary of `Swift`. Literally, it works like `JSON.parse()` in `JavaScript`. 

### Usage
```swift
struct JsonValue: Codable {
    @Jsonable var json: Any
}
```

## Author
__Dscyre Scotti__ (__[@dscyrescotti](https://twitter.com/dscyrescotti)__)

## Credits
__CodableX__ is inspired by __[BetterCodable](https://github.com/marksands/BetterCodable)__ and __[AnyCodable](https://github.com/levantAJ/AnyCodable)__.

## Contributions
__CodableX__ welcomes all developers to contribute if you have any idea to improve and open an issue if you find any kind of bug.

## License
CodableX is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
