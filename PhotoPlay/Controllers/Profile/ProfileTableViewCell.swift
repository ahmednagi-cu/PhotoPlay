//
//  ProfileTableViewCell.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 08/10/2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
   static let identifier = "ProfileTableViewCell"
    
    @IBOutlet weak var profileLBL: UILabel!
    
    @IBOutlet weak var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
