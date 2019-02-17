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
    case hello
}

extension WeatherService: TargetType {
    var baseURL: URL { return URL(string: Constants.weatherServerUrl)! }
    var path: String {
        switch self {
        case .hello:
            return "/weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .hello:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
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
        case .hello:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        default: // Send no parameters
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
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
