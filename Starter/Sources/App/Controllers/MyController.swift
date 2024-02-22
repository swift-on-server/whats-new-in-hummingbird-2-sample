import Foundation
import Hummingbird
import NIO

extension MyModel: HBResponseCodable {}

struct MyController<Context: HBRequestContext> {

    func addRoutes(to group: HBRouterGroup<Context>) {
        group
            .get(use: list)
            .post(use: create)
    }

    @Sendable 
    func list(
        _ request: HBRequest,
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
        _ request: HBRequest,
        context: Context
    ) async throws -> HBEditedResponse<MyModel> {
        let input = try await request.decode(
            as: MyModel.self,
            context: context
        )
        return .init(status: .created, response: input)
    }
}
