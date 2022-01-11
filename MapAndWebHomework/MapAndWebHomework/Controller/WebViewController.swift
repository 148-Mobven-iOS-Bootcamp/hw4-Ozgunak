//
//  ViewController.swift
//  MapAndWebHomework
//
//  Created by ozgun on 11.01.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureWebView()
    }
    
    var urlString = "https://www.google.com"
    var isSafariTapped: Bool = false
    
    func configureWebView() {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.isLoading),
                            options: .new,
                            context: nil)
        if isSafariTapped {
            UIApplication.shared.open(webView.url ?? url)
        }else {
            webView.load(urlRequest)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            webView.isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
    @IBAction func backTapped(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func forwardTapped(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    @IBAction func safariTapped(_ sender: UIBarButtonItem) {
        isSafariTapped = true
        configureWebView()
    }
}

extension WebViewController: WKNavigationDelegate {
}

extension WebViewController: WKUIDelegate {
}
