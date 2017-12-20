//
//  UserDetailViewController.swift
//  TheMormons
//
//  Created by Sterling Mortensen on 12/19/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    var user: User?
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var forceSensitiveLabel: UILabel!
    @IBOutlet weak var affiliationLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
    }
    
    func updateViews() {
        guard let user = self.user else { return }
        print(user.profilePicture! as UIImage) 
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
        birthdateLabel.text = user.birthdate
        forceSensitiveLabel.text = "\(user.forceSensitive)"
        affiliationLabel.text = user.affiliation
        profileImage.image = user.profilePicture
        if user.affiliation == "JEDI" {
            backgroundImageView.image = UIImage(named: "jedi")
        } else if user.affiliation == "RESISTANCE" {
            backgroundImageView.image = UIImage(named: "resistance")
        } else if user.affiliation == "FIRST_ORDER" {
            backgroundImageView.image = UIImage(named: "firstOrder")
        } else if user.affiliation == "SITH" {
            backgroundImageView.image = UIImage(named: "sithLord")
        }
    }
}
