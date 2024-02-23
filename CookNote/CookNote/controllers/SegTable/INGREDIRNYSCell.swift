//
//  INGREDIRNYSCell.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/30.
//

import UIKit

class INGREDIRNYSCell: UITableViewCell {
    let dao = IngredientsListDAO.shared
    var list = [IngredientsList]()
    var rid = 0
    var select = -1
    var table: UIViewController?
    @IBOutlet weak var ingredentLabel: UILabel!
    @IBOutlet weak var quentityLabel: UILabel!
    @IBOutlet weak var heart: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        heart.isUserInteractionEnabled = true
        let tapper = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        heart.addGestureRecognizer(tapper)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func tapHandler(_ sender: UITapGestureRecognizer) {
        
        if select == 1{
            if let data = dao.getIngredientsListById(rid){
                var d = data
                d.selectNum = 2
                dao.update(d)
                heart?.image = UIImage(named: "check")
                select = 2
                print(dao.getIngredientsListById(rid) ?? IngredientsList())
            }
        }else{
            select = 2
            if let data = dao.getIngredientsListById(rid){
                var d = data
                d.selectNum = 1
                dao.update(d)
                heart?.image = UIImage(named: "checkNo")
                select = 1
                print(dao.getIngredientsListById(rid) ?? IngredientsList())
            }
       }
        table?.viewWillAppear(true)
        
    }
    
}
