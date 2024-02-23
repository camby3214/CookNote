//
//  DELETCell.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/8/2.
//

import UIKit

class DELETCell: UITableViewCell {

    let dao = IngredientsListDAO.shared
    var list = [IngredientsList]()
    var igroup = -1
    var animated = true
    var tableViewController: UITableViewController?
    
    var section: Int?
    @IBAction func button(_ sender: Any) {
        dao.update2(igroup)
        tableViewController?.viewWillAppear(true)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        }
    
        
}
    

