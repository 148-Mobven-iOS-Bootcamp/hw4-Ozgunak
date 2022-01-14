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
    var isSafariTapped = false
    var ishtmlTapped = false
    var isFontTapped = false
    var fontFamily = "'Times New Roman', Times, serif"
    var htmlString: String {"""
                    <!doctype html>
                    <meta charset="utf-8"/>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <html><head>
                        <style>body {font-size: 36px;font-family: \(fontFamily);text-align: center;height: 100vh;display:flex;}
                                .container{display: grid;align-items: center;justify-content: center;width:90vw;height: 90vh;margin: auto;}
                                .element{margin: auto;}
                        </style>
                        </head><body><div class="container"><div class="element">
                                    Hello, <span class="custom">Bootcamp!</span>
                        </body></html>
                    """}
    
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
        //MARK: - Homework safari, html and font sections

        // Opens current url in safari
        if isSafariTapped {
            UIApplication.shared.open(webView.url ?? url)
            isSafariTapped = false
        }else {
            webView.load(urlRequest)
        }
        // Opens html string
        if ishtmlTapped {
            webView.loadHTMLString(htmlString, baseURL: nil)
            
            ishtmlTapped = false
        }
        // Chances font family
        if isFontTapped {
            fontFamily = "AmericanTypewriter"
            webView.loadHTMLString(htmlString, baseURL: nil)
            fontFamily = "'Times New Roman', Times, serif"

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
    @IBAction func safariTapped(_ sender: UIBarButtonItem) {
        isSafariTapped = true
        configureWebView()
    }
    @IBAction func htmlTapped(_ sender: UIBarButtonItem) {
        ishtmlTapped = true
        configureWebView()
    }
    @IBAction func fontTapped(_ sender: UIBarButtonItem) {
        isFontTapped = true
        configureWebView()
    }
}

extension WebViewController: WKNavigationDelegate {
}

extension WebViewController: WKUIDelegate {
}
