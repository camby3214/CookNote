//
//  BuyTableViewController.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/8/2.
//

import UIKit

class BuyTableViewController: UITableViewController {

    let ingredientsDao = IngredientsListDAO.shared
    let cookbooksDao = CookbooksDAO.shared
    var ingredientsList = [IngredientsList]()
    var ingredientsList2 = [IngredientsList]()
    var cookbookList = [Cookbooks]()
    
    var selectList = [Int]()
    var sectionlist = [Int]()
    var rowList = [Int]()
    var rowListNum: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "BUYCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier:"BUYCell")
        let nib2 = UINib(nibName: "DELETCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier:"DELETCell")
        let nib3 = UINib(nibName: "INGREDINTSCell", bundle: nil)
        tableView.register(nib3, forCellReuseIdentifier:"INGREDINTSCell")
        let nib4 = UINib(nibName: "SecondTableViewCell", bundle: nil)
        tableView.register(nib4, forCellReuseIdentifier:"SecondTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

    }

    override func viewWillAppear(_ animated: Bool) {
        cookbookList = cookbooksDao.getAllCookbooks()
        ingredientsList = ingredientsDao.getIngredientsListBySelectNum()
        selectList = []
        //如果有食材被選中
        rowList = []
        if ingredientsList.count != 0{
            //選中食材的group array    ex:[1, 1, 1, 2, 2, 4, 4]
            for num in 0...ingredientsList.count - 1{
                selectList.append(ingredientsList[num].igroup)
            }
            //有幾個食譜被選中 ex:[1, 2, 4]
            for num in 0...selectList.count - 1{
                if !sectionlist.contains(ingredientsList[num].igroup){
                    sectionlist.append(ingredientsList[num].igroup)
                }
            }
        
        //rowList初始化 ex:[0, 0, 0]
        rowList = sectionlist
        for num in 0...sectionlist.count - 1{
            rowList[num] = 0
        }
        
        //rowList值為每一個section有幾個row  ex:[3, 2, 2]
        for num in 0...sectionlist.count - 1{
            for num2 in 0...selectList.count - 1{
                if sectionlist[num] == selectList[num2]{
                    rowList[num] += 1
                }
            }
        }
        } 
//        print(selectList)
//        print(sectionlist)
        print(rowList)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionlist.count
        
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        for num in 0...rowList.count{
            if section == num {
                rowListNum = num
//                print("section = \(section) row = \(rowList[rowListNum])")
            }
        }
        if rowList.count == 0 || rowList[section] == 0{
            return 0
        } else {
            return rowList[section] + 3
        }
        
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let a = rowList
        switch indexPath.row {
        case a[indexPath.section] + 2:
            return 10
        default:
            return 40
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let a = rowList
        switch indexPath.row {
        case 0:
            var data = 0
            let cell = tableView.dequeueReusableCell(withIdentifier: "BUYCell", for: indexPath) as! BUYCell
            for num in 0...rowList.count {
                if indexPath.section == num{
                    data = cookbookList[sectionlist[num] - 1 ].rid
                }
            }
            if let dataCookList = cookbooksDao.getCookbooksById(data){
                cell.foodName?.text = dataCookList.food
            }
            return cell
        case a[indexPath.section] + 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DELETCell", for: indexPath) as! DELETCell
            var igroup = -1
            for num in 0...sectionlist.count - 1{
                if indexPath.section == num{
                   igroup = sectionlist[num]
                    print(igroup)
                }
            }
            cell.tableViewController = self
            cell.section = indexPath.section
            cell.igroup = igroup
            return cell

        case a[indexPath.section] + 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "INGREDINTSCell", for: indexPath) as! INGREDINTSCell
            var igroup = -1
            igroup = sectionlist[indexPath.section]
//            for num in 0...sectionlist.count - 1{
//                if indexPath.section == num{
//                    igroup = sectionlist[num]
//                    print(igroup)
//                }
//            }
            ingredientsList2 = ingredientsDao.getIngredientsListBySelectNum2(igroup)
//            print(ingredientsList2)
//            if ingredientsList2.count == 0{
//                return cell
//            }else{
        
                let data = ingredientsList2[indexPath.row - 1]
                cell.ingredintsLabel.text = data.ingredients
                cell.quentityLabel.text = data.quantity
                return cell
//            }
            
        }
        
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
