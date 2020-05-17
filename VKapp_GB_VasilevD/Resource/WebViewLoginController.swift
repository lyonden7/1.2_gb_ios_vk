//
//  WebViewLoginController.swift
//  VKapp_GB_VasilevD
//
//  Created by Денис Васильев on 17/05/2020.
//  Copyright © 2020 Denis Vasilev. All rights reserved.
//

import UIKit
import WebKit

class WebViewLoginController: UIViewController {

    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7247767"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
    
}

extension WebViewLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else { decisionHandler(.allow); return }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String:String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        
        guard let token = params["access_token"],
            let userIDString = params["user_id"],
            let userIDInt = Int(userIDString) else {
                decisionHandler(.allow)
                return
        }
        
        Session.instance.accessToken = token
        Session.instance.userID = userIDInt
        
        performSegue(withIdentifier: "Run the App", sender: nil)
        decisionHandler(.cancel)
    }
}
