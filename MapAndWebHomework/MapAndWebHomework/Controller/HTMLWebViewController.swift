//
//  HTMLWebViewController.swift
//  MapAndWebHomework
//
//  Created by ozgun on 14.01.2022.
//

import UIKit
import WebKit

class HTMLWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        load(with: htmlString)
    }
    
    
    func load(with htmlString: String){
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    

    @IBAction func defaultPressed(_ sender: UIBarButtonItem) {
        fontFamily = "'Times New Roman', Times, serif"
        load(with: htmlString)
    }
    
    @IBAction func font1Pressed(_ sender: UIBarButtonItem) {
        fontFamily = "AmericanTypewriter"
        load(with: htmlString)
    }
    
    @IBAction func font2Pressed(_ sender: UIBarButtonItem) {
        fontFamily = "Georgia"
        load(with: htmlString)
    }
}
