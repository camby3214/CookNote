//
//  ViewController.swift
//  DevM12_Network
//
//  Created by 李韋辰 on 2021/7/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let get_link = "http://ikenapp.appspot.com/json/getCategory.jsp"
    let post_link = "http://ikenapp.appspot.com/json/postProductsByCategory.jsp"
    let queryString = "cateId="
    override func viewDidLoad() {
        super.viewDidLoad()
//        getDataByString()
        getDataByNSURLConnectionSync()
//        postDataByNSURLConnectionAsync(1)
        
//        pickerView.dataSource = self
//        pickerView.delegate = self
    }

    //POST + Async
    func postDataByNSURLConnectionAsync(_ num: Int){
        if let url = URL(string: post_link) {
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            let bodyStr = "\(queryString)\(num)"
            req.httpBody = bodyStr.data(using: .utf8)
            NSURLConnection.sendAsynchronousRequest(req, queue: OperationQueue.main, completionHandler: {(res, data, error) in
                if let err = error {
                print("ERROR: \(err)")
                return
                }
                if let returnData = data, let result = String(data: returnData, encoding: .utf8) {
                    print("RESULT:\n\(result)")
                    self.display.text = result
                }
            })
        }
    }
    
//    fileprivate func parseJSONByJSONSerialization(_ data: Data) {
//        if let data = try? NSURLConnection.sendSynchronousRequest(req, returning: nil) {
//            if let array = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:String]] {
//                for dict in array {
//                    print("----------------")
//                    print("[id] = \(dict["id"] ?? "")")
//                    print("[cate_name] = \(dict["cate_name"] ?? "")")
//
//                }
//            }
//        }
//    }
    
    
    
    
    
    //GET + Sync
    func getDataByNSURLConnectionSync() {
        if let url = URL(string: get_link) {
            let req = URLRequest(url: url)
//            if let data = try? NSURLConnection.sendSynchronousRequest(req, returning: nil), let result = String(data: data, encoding: .utf8) {
//                print(result.trimmingCharacters(in: .whitespacesAndNewlines))
//                display.text = result
//
//            }
            if let data = try? NSURLConnection.sendSynchronousRequest(req, returning: nil) {
//                parseJSONByJSONSerialization(data)
                parseJSONByJSONDecoder(data)
            }
            
        }
    }
    
    fileprivate func parseJSONByJSONDecoder(_ data: Data) {
        if let list = try? JSONDecoder().decode([Category].self, from: data) {
            for cate in list {
                print("==============")
                print("id = \(cate.id), cate_name = \(cate.cate_name)")
            }
        }
    }
    
    
    
    //GET + Sync
    func getDataByString() {
        if let url = URL(string: get_link), let result = try?
            String(contentsOf: url, encoding: .utf8) {
            print(result)
        }
    }

}

//JSON Parsing: Step1
struct  Category: Codable {
    var id = ""
    var cate_name = ""
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        postDataByNSURLConnectionAsync(row + 1)
    }
}
