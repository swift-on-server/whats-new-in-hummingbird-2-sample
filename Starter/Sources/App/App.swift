import ArgumentParser
import Hummingbird

@main
struct HummingbirdArguments: AsyncParsableCommand {

    func run() async throws {
        let app = try await buildApplication()
        try await app.runService()
    }
}
