//
//  ViewController.swift
//  WebKitApp
//
//  Created by macbook on 16.11.2023.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    let webView: WKWebView = {
        let preapple = WKWebpagePreferences()
        preapple.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preapple
        let webView = WKWebView(frame: .zero,
                                configuration: configuration)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        guard let url = URL(string: "https://apple.com") else {return}
        
        webView.load(URLRequest(url: url))
        webView.customUserAgent = "IPad/Chrome/SomethingRandom"
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.webView.evaluateJavaScript("document.body.innerHTML") { result, error in
                guard let html = result as? String, error == nil else {
                    return
                }
                print(html)
                
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

}

