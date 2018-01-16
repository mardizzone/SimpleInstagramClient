//
//  parseJSON.swift
//  Instagram23
//
//  Created by Michael Ardizzone on 1/11/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

//Structs and Methods used to Parse Instagram Data

import Foundation
import Alamofire

//Use structs to parse JSON - new in Swift 4

struct InstagramData : Codable {
    let data : [ImageInfo]
}

struct ImageInfo : Codable {
    let images : ImageResolutions
    let id : String
    let user_has_liked : Bool
}

struct ImageResolutions : Codable {
    let low_resolution: Resolution
    let standard_resolution: Resolution
}

struct Resolution : Codable {
    let url : String
}

class parseJSON {
    class func parseInstagramData(data: Data) -> InstagramData? {
        let decoder = JSONDecoder()
        do {
            let instagramData = try decoder.decode(InstagramData.self, from: data)
            return instagramData
        } catch {
            print("error trying to convert data to JSON")
            print(error)
            return nil
        }
    }
}

