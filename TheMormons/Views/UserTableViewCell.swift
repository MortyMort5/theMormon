//
//  UserTableViewCell.swift
//  TheMormons
//
//  Created by Sterling Mortensen on 12/19/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var user: User? {
        didSet {
            self.updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateViews() {
        guard let user = self.user else { return }
        
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.image = user.profilePicture
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
    }
}
