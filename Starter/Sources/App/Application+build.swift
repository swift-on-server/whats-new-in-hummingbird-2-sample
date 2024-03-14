import Foundation
import Hummingbird
import Logging

func buildApplication() async throws -> some ApplicationProtocol {
    
    let router = Router(context: MyBaseRequestContext.self)
    
    router.middlewares.add(LogRequestsMiddleware(.info))
    router.middlewares.add(FileMiddleware())
    router.middlewares.add(CORSMiddleware(
        allowOrigin: .originBased,
        allowHeaders: [.contentType],
        allowMethods: [.get, .post, .delete, .patch]
    ))

    router.get("/health") { _, _ -> HTTPResponse.Status in
        .ok
    }

    MyController().addRoutes(to: router.group("api"))

    return Application(
        router: router,
        configuration: .init(
            address: .hostname("localhost", port: 8080)
        )
    )
}
