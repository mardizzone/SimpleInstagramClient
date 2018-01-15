//
//  ViewController.swift
//  Instagram23
//
//  Created by Michael Ardizzone on 1/10/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet var authorizationWebView: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        startSpinner()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func loadWebView() {
        authorizationWebView.load(Constants.Instagram.authorizationURLRequest)
        authorizationWebView.navigationDelegate = self
    }
    
    private func startSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    private func stopSpinner() {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        storeAccessTokenAndShowPhotosVC(webView)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopSpinner()
    }
    
    private func storeAccessTokenAndShowPhotosVC(_ input: WKWebView) {
        if let accessToken = extractTokenFromURL(for: input) {
            KeychainHelper.shared.setAccessToken(accessToken: accessToken)
            InstagramRouter.showInstagramPhotosView()
        }
    }

}



