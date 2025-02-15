import Swifter

extension HttpServer {
    func addResponse(for endpoint: MocksEnpoint) {
        self[endpoint.path] = { _ in
            guard let mockResponse = endpoint.data else {
                return HttpResponse.notFound
            }
            return HttpResponse.raw(200, "OK", ["Content-Type": "application/json"], { writer in
                try writer.write(mockResponse)
            })
        }
    }
}
