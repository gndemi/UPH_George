//
//  DashboardItemTableViewCell.swift
//  
//
//  Created by Aakash Sheth on 3/20/16.
//
//

import UIKit

class DashboardItemTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var CardType: UILabel!
    @IBOutlet weak var CardDescription: UILabel!
    @IBOutlet weak var CardValue: UILabel!
    @IBOutlet weak var CardImage: UIImageView!
    @IBOutlet weak var CardLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 1
        self.layer.shadowOffset = CGSize(width: -0.2, height: 0.2)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.2
        
        self.backgroundColor = UIColor(colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
