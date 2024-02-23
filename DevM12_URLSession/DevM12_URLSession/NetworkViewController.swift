//
//  NetworkViewController.swift
//  DevM12_URLSession
//
//  Created by 李韋辰 on 2021/7/29.
//

import UIKit

class NetworkViewController: UIViewController {
    @IBOutlet weak var pickView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    //Step5
    var list: [Product]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
        
    }
    func  initSubviews(){
        list = [Product]()
//        list = [Product(prod_name: "iphone12")]
        //Step4
        pickView.dataSource = self
        pickView.delegate = self
        //Step6
        tableView.dataSource = self
        
    }

    
}
//Step4
//MARK: - PickerView DataSource
extension NetworkViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    
}

//MARK: - PickerView Delegate
let post_link = "http://ikenapp.appspot.com/json/postProductsByCategory.jsp"
let queryString = "cateId"
extension NetworkViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("\(row + 1)")
        let idx = "\(row + 1)"
        
        if let url = URL(string: post_link) {
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            let bodyString = "\(queryString)\(idx)"
            req.httpBody = bodyString.data(using: .utf8)
            
            URLSession.shared.dataTask(with: req) {(data, res, error) in
                if let err = error {
                    print(err)
                    return
                }
                if let jsonData = data {
                    self.parseJSON(jsonData)
                }
            }.resume()
        }
    }
    func parseJSON(_ jsonData: Data) {
        if let array = try? JSONDecoder().decode([Product].self, from: jsonData) {
            updateUI(array)
        } else {
            showErrorMessage()
        }
    }
    func updateUI(_ array: [Product]){
        DispatchQueue.main.async {
            self.list = array
            self.tableView.reloadData()
        }
    }
    func showErrorMessage(){
        DispatchQueue.main.async {
            let con = UIAlertController(title: "JSON Data Error", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            con.addAction(ok)
            self.present(con, animated: true, completion: nil)
        }
    }
    
    
}

//Step6
//MARK: - TableView DataSource
extension NetworkViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        let prod = list[indexPath.row]
        cell.textLabel?.text = prod.prod_name
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    
}

//MARK: - TableView Delegate
extension NetworkViewController: UITableViewDelegate{
    
}
