Pod::Spec.new do |spec|
    spec.name         = "CodableX"
    spec.version      = "0.1.1"
    spec.summary      = "Make Swift's Codable easier using Property Wrappers."
    spec.description      = <<-DESC
    CodableX provides the property wrappers that are pretty handy to decode and encode structs or classes as you desire without implementing your custom codable structs or classes from scratch.
                       DESC
    spec.homepage     = "https://github.com/dscyrescotti/CodableX"
    spec.license      = { :type => "MIT", :file => "LICENSE" }
    spec.author             = { "Dscyre Scotti" => "dscyrescotti@gmail.com" }
    spec.social_media_url = 'https://twitter.com/dscyrescotti'
    spec.documentation_url = "https://github.com/dscyrescotti/CodableX"
    spec.swift_version = "5.0"
    spec.source       = { :git => "https://github.com/dscyrescotti/CodableX.git", :tag => "#{spec.version}" }
    spec.source_files  = "Sources/CodableX/**/*.swift"
    spec.xcconfig = { "SWIFT_VERSION" => "5.3" }
    spec.ios.deployment_target = '9.0'
    spec.osx.deployment_target = "10.11"
    spec.watchos.deployment_target = "3.0"
    spec.tvos.deployment_target = "9.0"
end