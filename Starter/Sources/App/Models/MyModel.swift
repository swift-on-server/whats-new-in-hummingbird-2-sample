import Hummingbird

struct MyModel: Codable {
    let title: String
}

extension MyModel: ResponseCodable {}
