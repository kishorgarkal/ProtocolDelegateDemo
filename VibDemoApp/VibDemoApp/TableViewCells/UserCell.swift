//
//  UserCell.swift
//  VibDemoApp
//
//  Created by MYGENOMEBOX INDIA on 30/07/21.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var img_View: UIImageView!
  
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
   
    @IBOutlet weak var btnRemove: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
