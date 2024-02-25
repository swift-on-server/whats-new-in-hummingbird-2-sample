import Foundation
import Hummingbird
import Logging

func buildApplication() async throws -> some HBApplicationProtocol {
    
    let router = HBRouter(context: MyBaseRequestContext.self)
    
    router.middlewares.add(HBLogRequestsMiddleware(.info))
    router.middlewares.add(HBFileMiddleware())
    router.middlewares.add(HBCORSMiddleware(
        allowOrigin: .originBased,
        allowHeaders: [.contentType],
        allowMethods: [.get, .post, .delete, .patch]
    ))

    router.get("/health") { _, _ -> HTTPResponse.Status in
        .ok
    }

    MyController().addRoutes(to: router.group("api"))

    return HBApplication(
        router: router,
        configuration: .init(
            address: .hostname("localhost", port: 8080)
        )
    )
}
