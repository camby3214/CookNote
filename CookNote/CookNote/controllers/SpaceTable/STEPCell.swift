//
//  STEPCell.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/30.
//

import UIKit

class STEPCell: UITableViewCell {
    @IBOutlet weak var foodPhoto: UIImageView!
    @IBOutlet weak var stepLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
