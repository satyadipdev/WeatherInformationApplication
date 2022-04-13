//
//  RequestPath.swift
//
//

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
}
