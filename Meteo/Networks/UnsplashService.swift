//
//  WeatherService.swift
//  Meteo
//
//  Created by Jeoffrey Thirot on 15/02/2019.
//  Copyright © 2019 Jeoffrey Thirot. All rights reserved.
//

import UIKit
import Moya

enum UnsplashService {
    case search(keyword: String)
}

extension UnsplashService: TargetType {
    var baseURL: URL { return URL(string: Constants.unsplashServerUrl)! }
    var path: String {
        switch self {
        case .search:
            return "/search/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .search(let keyword):
            return ["client_id": Constants.unsplashToken, "query": keyword, "page": "1"]
        default:
            return [String: Any]()
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        switch self {
        case .search(_):
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        default: // Send no parameters
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .search:
            return _getLocalJson(name: "search")
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    public func clearCache(urlRequests: [URLRequest] = []) {
        let provider = MoyaProvider<UnsplashService>()
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
