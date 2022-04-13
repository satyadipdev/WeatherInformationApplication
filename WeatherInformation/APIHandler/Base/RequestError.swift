//
//  RequestError.swift
//
//

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    var customMessage: String {
        switch self {
        default:
            return "City not found"
        }
    }
}
