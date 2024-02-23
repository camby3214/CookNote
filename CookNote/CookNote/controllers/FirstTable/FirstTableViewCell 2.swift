//
//  FirstTableViewCell.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/29.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var authorPhoto: UIImageView!
    @IBOutlet weak var food: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBAction func btm(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    
    
}
