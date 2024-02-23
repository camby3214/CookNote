//
//  ViewController.swift
//  Dev12_WebView
//
//  Created by 李韋辰 on 2021/7/28.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    //UI
    @IBOutlet weak var webView: WKWebView!
    //Data
    //Step7
    var day = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "iOS Dev Day \(day)"
        //if let url = URL(string: "https://www.uuu.com.tw"){
        if let filePath = Bundle.main.path(forResource: "iOSDev_Day\(day)", ofType: "pdf") {
            
            webView.load(URLRequest(url: URL(fileURLWithPath: filePath)))
        }
    }


}

