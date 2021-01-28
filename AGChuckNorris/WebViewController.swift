//
//  WebViewController.swift
//  AGChuckNorris
//
//  Created by iMac on 28.01.2021.
//  Copyright © 2021 AlexGermek. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var indicatorWeb: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myWebView.navigationDelegate = self
        
        let string = "http://www.icndb.com/api/"
        
        let url = URL(string: string)
        
        let requestObj = URLRequest(url: url! as URL)
        
        myWebView.load(requestObj)
    }
    
    //MARK: WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicatorWeb.stopAnimating()
    }
}
