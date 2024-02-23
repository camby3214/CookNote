//
//  HybridViewController.swift
//  Dev12_WebView
//
//  Created by 李韋辰 on 2021/7/28.
//

import UIKit
import WebKit
class HybridViewController: UIViewController {
    
    //Step12
    @IBOutlet weak var webView: WKWebView!
    @IBAction func handler(_ sender: UIBarButtonItem) {
        let js = "showItem('overview\(sender.tag)')"
        print(sender.tag)
        webView.evaluateJavaScript(js, completionHandler: nil)
    }
    
    //Step13
    override func viewDidAppear(_ animated: Bool) {
        if let path = Bundle.main.path(forResource: "home", ofType: "html"){
            webView.load(URLRequest(url: URL(fileURLWithPath: path)))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegate Step3
        webView.navigationDelegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - WKNavigation Delegate
//Delegate Step1
extension HybridViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    //處理網址列
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let link = navigationAction.request.url?.absoluteURL.absoluteString,let string =  link.removingPercentEncoding{
//            print(link)
            if string.hasPrefix("app:") {
                let array = string.split(separator: ":")
                if array.count == 2 && array[1] == "Mail" {
                    if array[1] == "Mail" {
                        print(array[1])
                        decisionHandler(.cancel)
                        let con = UIImagePickerController()
                        con.sourceType = .photoLibrary
                        present(con, animated: true, completion: nil)
                        return
                    }
                }
                
            }
        }
        decisionHandler(.allow)
    }
}
