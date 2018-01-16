//
//  Methods.swift
//  Instagram23
//
//  Created by Michael Ardizzone on 1/11/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation
import WebKit

func extractTokenFromURL(for webview: WKWebView) -> String? {
    guard let urlString = webview.url?.absoluteString else {return nil}
    if let rangeForToken = urlString.range(of: "#access_token=") {
        let indexForToken = urlString.index(rangeForToken.upperBound, offsetBy: 0)
        let token = urlString[indexForToken...]
        return String(token)
    } else {
        return nil
    }
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

//we don't want the access token to be left over in the URL once it's removed
class WebCacheCleaner {
    class func clean() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}
