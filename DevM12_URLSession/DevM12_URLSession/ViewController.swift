//
//  ViewController.swift
//  DevM12_URLSession
//
//  Created by 李韋辰 on 2021/7/29.
//

import UIKit

let dropbox_link = "https://www.dropbox.com/s/wjpandtr7lty3uj/data.json?dl=1"//Can access by Http GET only
class ViewController: UIViewController {
    @IBOutlet weak var display: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDropboxDataByURLSession()
    }

    
    //GET + Async
    func getDropboxDataByURLSession() {
        if let url = URL(string: dropbox_link) {
            let req = URLRequest(url: url)
            let session = URLSession.shared
            
            //Background Thread
            session.dataTask(with: req) { (data, res, error) in
                if let err = error {
                    print(err)
                    return
                }
                if let result = data, let string = String(data: result, encoding: .utf8) {
                    print(string)
                    DispatchQueue.main.async {
                        self.display.text = string
                    }
                    
                }
            }.resume()
        }
    }

}

