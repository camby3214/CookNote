//
//  INGREDINTSCell.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/8/3.
//

import UIKit

class INGREDINTSCell: UITableViewCell {
    @IBOutlet weak var ingredintsLabel: UILabel!
    @IBOutlet weak var quentityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
