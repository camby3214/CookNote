//
//  FirstTableViewCell.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/29.
//

import UIKit
import SwiftUI


class FirstTableViewCell: UITableViewCell {
    

    var rid = -1
    var favorite = -1
    let dao = CookbooksDAO.shared
    var list = [Cookbooks]()
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var authorPhoto: UIImageView!
    @IBOutlet weak var food: UILabel!
    @IBOutlet weak var authorName: UILabel!
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
        
        if favorite == 1 {
            if let dat = dao.getCookbooksById(rid){
                var d = dat
                d.favorite = 2
                dao.update(d)
                heart?.image = UIImage(named: "heartfill")
                favorite = 2
            }
        }else{
            if let dat = dao.getCookbooksById(rid){
                var d = dat
                d.favorite = 1
                dao.update(d)
                heart?.image = UIImage(named: "heart1")
                favorite = 1

           }
       }
        
        
    }
    
}

