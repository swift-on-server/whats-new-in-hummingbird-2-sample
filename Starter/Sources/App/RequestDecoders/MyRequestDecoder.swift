import Hummingbird

struct MyRequestDecoder: HBRequestDecoder {

    func decode<T>(
        _ type: T.Type,
        from request: HBRequest,
        context: some HBBaseRequestContext
    ) async throws -> T where T: Decodable {
        guard let header = request.headers[.contentType] else {
            throw HBHTTPError(.badRequest)
        }
        guard let mediaType = HBMediaType(from: header) else {
            throw HBHTTPError(.badRequest)
        }
        let decoder: HBRequestDecoder
        switch mediaType {
        case .applicationJson:
            decoder = JSONDecoder()
        case .applicationUrlEncoded:
            decoder = URLEncodedFormDecoder()
        default:
            throw HBHTTPError(.badRequest)
        }
        return try await decoder.decode(
            type,
            from: request,
            context: context
        )
    }
}
