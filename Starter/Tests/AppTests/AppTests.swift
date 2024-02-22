@testable import App
import Hummingbird
import HummingbirdXCT
import XCTest

final class AppTests: XCTestCase {

    func testList() async throws {
        let app = try await buildTestApplication()
        try await app.test(.router) { client in
            try await client.XCTExecute(
                uri: "/api",
                method: .get
            ) { response in
                guard response.status == .ok else {
                    return XCTFail("Invalid response code.")
                }
                let decoder = JSONDecoder()
                let items = try decoder.decode(
                    [MyModel].self,
                    from: response.body
                )
                XCTAssertEqual(items.count, 3)
            }
        }
    }
    
    func testCreate() async throws {
        let app = try await buildTestApplication()
        let encoder = JSONEncoder()
        let input = MyModel(title: "foo")
        let body = try encoder.encodeAsByteBuffer(input, allocator: .init())
        try await app.test(.router) { client in
            try await client.XCTExecute(
                uri: "/api",
                method: .post,
                body: body
            ) { response in
                guard response.status == .created else {
                    return XCTFail("Invalid response code.")
                }
                let decoder = JSONDecoder()
                let item = try decoder.decode(
                    MyModel.self,
                    from: response.body
                )
                XCTAssertEqual(item.title, "foo")
            }
        }
    }
}
