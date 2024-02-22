import Hummingbird
import Logging
import NIOCore

struct MyRequestContext: HBRequestContext {

    var coreContext: HBCoreRequestContext
    var myValue: String?

    init(
        channel: Channel,
        logger: Logger = .init(label: "my-request-context")
    ) {
        self.coreContext = .init(
            allocator: channel.allocator,
            logger: logger
        )
        self.myValue = nil
    }
    
    var requestDecoder: HBRequestDecoder {
        MyRequestDecoder()
    }
}
