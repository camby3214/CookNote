//
//  ViewController.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dao = CookbooksDAO.shared
        print(dao.getCookbooksByFavorite().count)
//        print(dao.getCookbooksByName("蛋").count)
//        if let data = dao.getCookbooksById(1){
//            print(data)
//        }
//        let dao1 = IngredientsListDAO.shared
//        print(dao1.getIngredientsListByGroup(2))
//
//        let dao2 = StepListDAO.shared
//        print(dao2.getAllStepList().count)
        
    }


}


