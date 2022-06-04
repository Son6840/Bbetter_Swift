//
//  News_TableViewCell.swift
//  Bbetter_Swift
//
//  Created by 모바일인터넷과 on 2022/05/29.
//

import UIKit

class News_TableViewCell: UITableViewCell {
    @IBOutlet weak var itTime : UILabel!
    @IBOutlet weak var itTitle : UILabel!
    
    @IBOutlet weak var culTime : UILabel!
    @IBOutlet weak var culTitle : UILabel!
    
    @IBOutlet weak var naTime : UILabel!
    @IBOutlet weak var naTitle : UILabel!
    
    @IBOutlet weak var ecoTime : UILabel!
    @IBOutlet weak var ecoTitle : UILabel!
    
    @IBOutlet weak var polTime : UILabel!
    @IBOutlet weak var polTitle : UILabel!
    
    @IBOutlet weak var socTime : UILabel!
    @IBOutlet weak var socTitle : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
