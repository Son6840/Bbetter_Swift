//
//  GoalTableViewCell.swift
//  Bbetter_Swift
//
//  Created by 강재혁 on 2022/06/01.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var DdayLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
