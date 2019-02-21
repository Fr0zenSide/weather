//
//  WeatherService.swift
//  Meteo
//
//  Created by Jeoffrey Thirot on 15/02/2019.
//  Copyright © 2019 Jeoffrey Thirot. All rights reserved.
//

import UIKit
import Moya

enum WeatherService {
    case currentWeather(lat: Int, long: Int)
    case hello
}

extension WeatherService: TargetType {
    var baseURL: URL { return URL(string: Constants.weatherServerUrl)! }
    var path: String {
        switch self {
        case .currentWeather:
            return "/weather"
        case .hello:
            return "/weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .currentWeather, .hello:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .currentWeather(let lat, let long):
            return ["APPID": Constants.openweathermapToken, "lat": lat, "lon": long, "units": "metric"]
        case .hello:
             return ["APPID": Constants.openweathermapToken, "lat": 45, "lon": 1]
        default:
            return [String: Any]()
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        switch self {
        case .currentWeather(_, _), .hello:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        default: // Send no parameters
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .currentWeather:
            return _getLocalJson(name: "currentWeather")
        case .hello:
            return _getLocalJson(name: "hello")
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    public func clearCache(urlRequests: [URLRequest] = []) {
        let provider = MoyaProvider<WeatherService>()
        guard let urlCache = provider.manager.session.configuration.urlCache else { return }
        if urlRequests.isEmpty {
            urlCache.removeAllCachedResponses()
        } else {
            urlRequests.forEach { urlCache.removeCachedResponse(for: $0) }
        }
    }
    
    private func _getLocalJson(name:String!) -> Data! {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        return data
    }
}
