//
//  Constants.swift
//  Boilerplate
//
//  Created by Jeoffrey Thirot on 07/11/2018.
//  Copyright © 2018 Jeoffrey Thirot. All rights reserved.
//

import Foundation
import KeychainAccess

class Constants {
    // MARK: - Variables
    // Private variables
    
    // Public variables
    
    static var weatherServerUrl = "https://api.openweathermap.org/data/2.5"
    // todo: Need to add an external lib to protect this kind of data and to import it from a file ignored by git in gitignore with template
    static var openweathermapToken: String {
        let keychain = Keychain(service: "me.jeoffrey.meteo")
        if let token = keychain["openweathermapToken"] { return token }
        return ""
    }
    static var locale = "fr"
    static var country = "fr"
    
    // MARK: - Getter & Setter methods
    
    
    // MARK: - Public methods
    
    static func description() -> String {
        let desc = """
        openweathermapToken: \(Constants.openweathermapToken),
        locale: \(Constants.locale),
        country: \(Constants.country)
        """
        return desc
    }
    
    // MARK: - Private methods
}
