//
//  News_TableViewCell.swift
//  Bbetter_Swift
//
//  Created by 모바일인터넷과 on 2022/05/29.
//

import UIKit

class News_TableViewCell: UITableViewCell {
    @IBOutlet weak var time : UILabel!
    @IBOutlet weak var nTl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
