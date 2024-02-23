//
//  CookPageViewController.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/30.
//

import UIKit

class CookPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var seg = "INGREDIRNYSCell"
    let dao = CookbooksDAO.shared
    var foodNum = 0
    
    
    var listCookbooks: Cookbooks?
    var listIngredients = [IngredientsList]()
    var listStepList =  [StepList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
    }
    @IBOutlet weak var foodPhoto: UIImageView!
    @IBOutlet weak var authorPhoto: UIImageView!
    @IBOutlet weak var food: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func segment(_ sender: UISegmentedControl) {
        let idx = sender.selectedSegmentIndex
        seg = idx == 0 ? "INGREDIRNYSCell":"STEPCell"
        tableView.reloadData()
        
    }
   

    
    override func viewWillAppear(_ animated: Bool) {
        listCookbooks = CookbooksDAO.shared.getCookbooksById(foodNum)
        listIngredients = IngredientsListDAO.shared.getIngredientsListByGroup(foodNum)
        listStepList = StepListDAO.shared.getStepListByGroup(foodNum)
        tableView.reloadData()
        
        self.food?.text = listCookbooks?.food
        self.author?.text = listCookbooks?.author
        
        if let foodPhoto = listCookbooks?.foodPhoto{
            self.foodPhoto.image = UIImage(data: foodPhoto)
        }
        if let authorPhoto = listCookbooks?.authorPhoto{
            self.authorPhoto.image = UIImage(data: authorPhoto)
            self.authorPhoto.layer.cornerRadius = self.authorPhoto.frame.height / 2
        }
        
    }
    func initSubviews() {
        let nib = UINib(nibName: "INGREDIRNYSCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "INGREDIRNYSCell" )
        let nib2 = UINib(nibName: "STEPCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "STEPCell" )
        let nib3 = UINib(nibName: "SecondTableViewCell", bundle: nil)
        tableView.register(nib3, forCellReuseIdentifier: "SecondTableViewCell" )
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch seg {
        case "INGREDIRNYSCell":
            return listIngredients.count
        default:
            return listStepList.count * 2 - 1
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch seg {
        case "INGREDIRNYSCell":
            let cell = tableView.dequeueReusableCell(withIdentifier: seg, for: indexPath) as! INGREDIRNYSCell
            let data = listIngredients[indexPath.row]
            cell.ingredentLabel?.text = data.ingredients
            cell.quentityLabel?.text = data.quantity
            cell.rid = data.rid
            cell.table = self
           cell.select = data.selectNum
            if data.selectNum == 1 {
                cell.heart?.image = UIImage(named: "checkNo")
            } else {
                cell.heart?.image = UIImage(named: "check")
            }
            return cell
        default:
            switch indexPath.row % 2 {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: seg, for: indexPath) as! STEPCell
                let data = listStepList[indexPath.row / 2]
                if let photo = data.image{
                    cell.foodPhoto?.image = UIImage(data: photo)
                } else {
                
                }
                cell.stepLabel?.text = data.instruction
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
                
                return cell
            }
            
        }
    }
}
//MARK: -TableView DataSource

    
    
    
    
    
    
    
    
    
    
    
