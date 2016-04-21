//
//  AuthenticationViewController.swift
//  CustomFit
//
//  Created by Farwa Naqi on 4/9/16.
//  Copyright © 2016 Farwa Naqi. All rights reserved.
//

import WebKit

class AuthenticationViewController: UIViewController {
    
    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        
        let loginURL = FitbitAPIManager.getLoginURL()
        let request = NSURLRequest(URL: loginURL)
        
        webView.loadRequest(request)
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        
        let views = ["webView": webView]
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|", options: .AlignAllCenterY, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[webView]|", options: .AlignAllCenterX, metrics: nil, views: views)
        
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalConstraints)
    }
    
    @IBAction func cancelLogin(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension AuthenticationViewController: WKNavigationDelegate {
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if let urlString = navigationAction.request.URL?.absoluteString {
            if urlString.hasPrefix(App.Callback) {
                if let components = NSURLComponents(string: urlString) {
                    if let accessToken = AuthUtils.generateAccessTokenFromString(components.fragment!) {
                        let result = AuthUtils.saveAccessToken(accessToken)
                        if !result {
                            print("Error: access token was not saved")
                        }
                    }
                }
                dismissViewControllerAnimated(true, completion: nil)
                decisionHandler(.Cancel)
            }
        }
        
        decisionHandler(.Allow)
    }
}
