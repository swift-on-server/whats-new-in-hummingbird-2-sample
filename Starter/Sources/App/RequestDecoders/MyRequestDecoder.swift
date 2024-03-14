import Hummingbird

struct MyRequestDecoder: RequestDecoder {

    func decode<T>(
        _ type: T.Type,
        from request: Request,
        context: some BaseRequestContext
    ) async throws -> T where T: Decodable {
        guard let header = request.headers[.contentType] else {
            throw HTTPError(.badRequest)
        }
        guard let mediaType = MediaType(from: header) else {
            throw HTTPError(.badRequest)
        }
        let decoder: RequestDecoder
        switch mediaType {
        case .applicationJson:
            decoder = JSONDecoder()
        case .applicationUrlEncoded:
            decoder = URLEncodedFormDecoder()
        default:
            throw HTTPError(.badRequest)
        }
        return try await decoder.decode(
            type,
            from: request,
            context: context
        )
    }
}
