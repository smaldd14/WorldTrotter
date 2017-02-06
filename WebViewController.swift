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
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL (string: "https://www.google.com")
        let request = NSURLRequest(URL: url as! URL)
        
        webView.load(NSURLRequest(url: URL(string: "https://www.google.com")! as URL) as URLRequest)
        
        print("WebViewController loaded its view.")
    }
}
