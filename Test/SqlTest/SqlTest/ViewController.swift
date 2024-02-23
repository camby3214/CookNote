//
//  ViewController.swift
//  SqlTest
//
//  Created by 李韋辰 on 2021/7/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dao = FoodDAO.share
        print(dao.getAllFoods().count)
        print(dao.getFoodByName("地瓜球").count)
        if let data = dao.getFoodById(1){
            print(data)
            dao.insert(data)
            print(dao.getAllFoods().count)
        } else {
            print("Not found")
        }
        
    }


}

