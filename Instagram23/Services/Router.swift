//
//  Router.swift
//  Instagram23
//
//  Created by Michael Ardizzone on 1/13/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import Foundation
import UIKit

class InstagramRouter {
    //Handle our router logic
    
    class func showInitialViewController() {
        if KeychainHelper.shared.retrieveAccessToken() != nil {
            showInstagramPhotosView()
        } else {
            showLoginScreenAtStartup()
        }
    }
    
    class func showLoginScreenAtStartup() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! ViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = loginViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    class func showInstagramPhotosView() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let photosViewController = storyBoard.instantiateViewController(withIdentifier: "photosViewController") as! PhotosViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = photosViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    class func presentLoginScreen(view: UIViewController) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! ViewController
        view.present(loginViewController, animated: true, completion: nil)
    }
}

