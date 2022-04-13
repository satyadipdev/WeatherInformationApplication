//
//
//  Created by Satyadip Singha on 08/04/22.
//  Copyright © 2022 Satyadip Singha. All rights reserved.
//

enum WeatherEndpoint {
    case weather(city: String, units: String, appID: String)
}

extension WeatherEndpoint: Endpoint {
    var path: String {
        switch self {
        case .weather(city: let city, units: let units, appID: let appid):
            return "weather?q=\(city)&appid=\(appid)&units=\(units)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .weather:
            return .get
        }
    }
    
    var header: [String: String]? {
        // Access Token to use in Bearer header
        switch self {
        case .weather:
            return nil
        }
    }
}
