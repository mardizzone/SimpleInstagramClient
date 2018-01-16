//
//  InstagramService.swift
//  Instagram23
//
//  Created by Michael Ardizzone on 1/15/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Alamofire

//requests to perform liking and disliking of the photos

class InstagramService {
    
    class func likePhoto(with id: String?, completionHandler: @escaping ((Bool) -> ())) {
        guard let token = KeychainHelper.shared.retrieveAccessToken() else {return}
        let requestParams: Parameters = ["access_token" : token]
        if let photoID = id {
            Alamofire.request("https://api.instagram.com/v1/media/\(photoID)/likes", method: .post, parameters: requestParams, encoding: URLEncoding.default).responseJSON {
                response in
                switch response.result {
                case .success:
                    completionHandler(true)
                case .failure(let error):
                    print(error)
                    completionHandler(false)
                }
            }
        }
    }
    
    class func dislikePhoto(with id: String?, completionHandler: @escaping ((Bool) -> ())) {
        guard let token = KeychainHelper.shared.retrieveAccessToken() else {return}
        let requestParams: Parameters = ["access_token" : token]
        if let photoID = id {
            Alamofire.request("https://api.instagram.com/v1/media/\(photoID)/likes", method: .delete, parameters: requestParams, encoding: URLEncoding.default).responseJSON {
                response in
            switch response.result {
                case .success:
                    completionHandler(true)
                case .failure(let error):
                    print(error)
                    completionHandler(false)
                }
            }
        }
    }
    
    
}
