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
        configureWebView()
    }
    
    var urlString = "https://www.google.com"

    //MARK: - Homework load func that opens in Safari

    func loadOnSafari(with url: URL){
        UIApplication.shared.open(url)
    }
    
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
        webView.load(urlRequest)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            webView.isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
    
    //MARK: - Homework toolbar buttons section

    @IBAction func backTapped(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func forwardTapped(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    //MARK: - open in safari

    // Opens current url in safari
    @IBAction func safariTapped(_ sender: UIBarButtonItem) {
        loadOnSafari(with: webView.url!)
    }
    
}

extension WebViewController: WKNavigationDelegate {
}

extension WebViewController: WKUIDelegate {
}
