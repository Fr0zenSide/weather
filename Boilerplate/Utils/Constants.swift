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
    
    static var kuzzleServerUrl = "http://localhost:7512" // ":6379"
    // todo: Need to add an external lib to protect this kind of data and to import it from a file ignored by git in gitignore with template
    static var apptweakToken: String {
        let keychain = Keychain(service: "me.jeoffrey.boilerplate")
        if let token = keychain["apptweakToken"] { return token }
        return ""
    }
    static var locale = "fr"
    static var country = "fr"
    
    // MARK: - Getter & Setter methods
    
    
    // MARK: - Public methods
    
    static func description() -> String {
        let desc = """
        apptweakToken: \(Constants.apptweakToken),
        locale: \(Constants.locale),
        country: \(Constants.country)
        """
        return desc
    }
    
    // MARK: - Private methods
}
