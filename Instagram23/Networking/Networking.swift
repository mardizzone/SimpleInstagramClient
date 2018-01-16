//
//  File.swift
//  Instagram23
//
//  Created by Michael Ardizzone on 1/14/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//
import Alamofire

class Networking {
    
    class func requestRecentDataFromInstagram(completionHandler : @escaping (InstagramData) -> Void) {
        guard let token = KeychainHelper.shared.retrieveAccessToken() else {return}
        let params: Parameters = ["access_token" : token]
        Alamofire.request("https://api.instagram.com/v1/users/self/media/recent/", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { response in
            switch response.result {
            case .success(let value):
                if let returnedData = parseJSON.parseInstagramData(data: value) {
                    completionHandler(returnedData)
                }
            case .failure(let error):
                if error.localizedDescription.contains(find: "OAuthAccessTokenException") {
                    //have the user login again if the token is expired
                    InstagramRouter.showInstagramPhotosView()
                }
            }
        }
    }
    
    //We could implement this function in the future when we are outside of Sandbox mode
    class func searchInstagram(searchTerm: String, completionHandler : @escaping (InstagramData) -> Void) {
        guard let token = KeychainHelper.shared.retrieveAccessToken() else {return}
        let params: Parameters = ["access_token" : token]
        Alamofire.request("https://api.instagram.com/v1/tags/\(searchTerm)/media/recent", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { response in
            switch response.result {
            case .success(let value):
                if let returnedData = parseJSON.parseInstagramData(data: value) {
                    completionHandler(returnedData)
                }
            case .failure(let error):
                if error.localizedDescription.contains(find: "OAuthAccessTokenException") {
                    //we have an expired token. Present login screen
                }
            }
        }
    }
    
}
