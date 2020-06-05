//
//  ProductDetailsViewController.swift
//  iOSTraining
//
//  Created by Admin on 31.05.20.
//  Copyright © 2020 Fjolle. All rights reserved.
//

import UIKit
import WebKit

class ProductDetailsViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var newsUrl: String?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var viewLoader: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpWebView()
        loadPage()
    }

func setUpWebView(){
    
    webView.uiDelegate = self
    webView.navigationDelegate = self
}

func loadPage(){
    
    let url = URL(string: newsUrl!)
    
    let urlRequest = URLRequest(url: url!)

    webView.load(urlRequest)
}

func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    print("Load finished!")
    }
}
