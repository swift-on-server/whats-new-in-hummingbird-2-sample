import Foundation
import Hummingbird
@testable import App

@MainActor
func buildTestApplication() async throws -> some HBApplicationProtocol {

    let router = HBRouter(context: MyBaseRequestContext.self)

    MyController().addRoutes(to: router.group("api"))

    return HBApplication(
        router: router,
        configuration: .init(
            address: .hostname("localhost", port: 8080)
        )
    )
}
