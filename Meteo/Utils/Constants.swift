//
//  Constants.swift
//  Boilerplate
//
//  Created by Jeoffrey Thirot on 07/11/2018.
//  Copyright © 2018 Jeoffrey Thirot. All rights reserved.
//

import Foundation
import CocoaLumberjack
import KeychainAccess

class Constants {
    // MARK: - Variables
    // Private variables
    
    // Public variables
    
    static var bundleIdentifier: String {
        return Bundle.main.bundleIdentifier ?? "me.jeoffrey.\(String(describing: UIDevice.current.identifierForVendor?.uuidString))"
    }
    
    static var weatherServerUrl = "https://api.openweathermap.org/data/2.5"
    // todo: Need to add an external lib to protect this kind of data and to import it from a file ignored by git in gitignore with template
    // Mark: - Manage Open Weather Map Token behavior
    static private var _openweathermapTokenKey = "openweathermapToken"
    static var openweathermapToken: String {
        let keychain = getKeychain()
        if let token = keychain[_openweathermapTokenKey] { return token }
        return ""
    }
    
    static func registerOpenweathermapToken() {
        _ = Constants.register(token: "", for: _openweathermapTokenKey)
    }
    
    static var locale = "fr"
    static var country = "fr"
    
    // MARK: - Getter & Setter methods
    
    
    // MARK: - Public methods
    
    // MARK: - Keychain behavior
    static func setupKeychain() -> Keychain {
        let keychain = Keychain(service: bundleIdentifier)
            .label("jeoffrey.me (Meteo)")
            .synchronizable(true)
        return keychain
    }
    
    static func getKeychain() -> Keychain {
        let keychain = Keychain(service: bundleIdentifier)
        return keychain
    }
    
    static func register(token: String, for key:String) -> String {
        // Setup api Tokens in keychain
        let keychain = getKeychain()
        if token == "" && (keychain[key] == nil || keychain[key] == "") {
            fatalError("Error! You need to add a tweak token for this app worked")
        } else if token != "" {
            keychain[key] = token
        }
        if let tokenRegistered = keychain[key] { DDLogDebug("🔑 The token(\(key)): \(tokenRegistered)") }
        return token
    }
    
    static func description() -> String {
        let desc = """
        \(_openweathermapTokenKey): \(Constants.openweathermapToken),
        locale: \(Constants.locale),
        country: \(Constants.country)
        """
        return desc
    }
    
    // MARK: - Private methods
}
