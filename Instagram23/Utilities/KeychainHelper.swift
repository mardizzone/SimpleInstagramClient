//
//  KeychainHelper.swift
//  Instagram23
//
//  Created by Michael Ardizzone on 1/11/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation
import KeychainAccess

//class used for storing the access token

class KeychainHelper {

    static let shared = KeychainHelper()
    
    private let keychain = Keychain(service: "com.instagram.access-token")

    func setAccessToken(accessToken: String) {
        keychain["accesstoken"] = accessToken
    }

    func retrieveAccessToken() -> String? {
        return keychain["accesstoken"] ?? nil
    }
    
    func revokeAccessToken() {
        keychain["accesstoken"] = nil
    }
    

}
