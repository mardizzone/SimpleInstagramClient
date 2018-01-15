//
//  Constants.swift
//  Instagram23
//
//  Created by Michael Ardizzone on 1/10/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation

struct Constants {
    struct Instagram {
        static let authorizationURLRequest : URLRequest = {
            let urlString = "https://api.instagram.com/oauth/authorize/?client_id=0637825256de4d9e9c969ec594b032c8&scope=likes&scope=public_content&redirect_uri=https://www.23andme.com&response_type=token"
            let url = URL(string: urlString)!
            return URLRequest(url: url)
        }()
    }
}
