import Foundation
import Hummingbird
import NIO

struct MyController<Context: MyRequestContext> {

    func addRoutes(
        to group: RouterGroup<Context>
    ) {
        group
            .get(use: list)
            .post(use: create)
    }

    @Sendable 
    func list(
        _ request: Request,
        context: Context
    ) async throws -> [MyModel] {
        [
            .init(title: "foo"),
            .init(title: "bar"),
            .init(title: "baz"),
        ]
    }

    @Sendable 
    func create(
        _ request: Request,
        context: Context
    ) async throws -> EditedResponse<MyModel> {
        // context.myValue
        let input = try await request.decode(
            as: MyModel.self,
            context: context
        )
        return .init(status: .created, response: input)
    }
}
