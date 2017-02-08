//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Devin Smaldore on 2/6/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myurl = URL(string: "https://www.google.com")
        let request = URLRequest(url: myurl!)
        
        webView.load(request)
        
        print("WebViewController loaded its view.")
    }
}
