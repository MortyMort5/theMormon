//
//  UsersTableViewController.swift
//  TheMormons
//
//  Created by Sterling Mortensen on 12/19/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserController.shared.fetchUsers {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.shared.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        let user = UserController.shared.users[indexPath.row]
        cell.user = user
        
        if user.affiliation == "JEDI" {
            cell.backgroundColor = UIColor(red: 229/255, green: 236/255, blue: 177/255, alpha: 0.5)
        } else if user.affiliation == "RESISTANCE" {
            cell.backgroundColor = UIColor(red: 131/255, green: 226/255, blue: 101/255, alpha: 0.5)
        } else if user.affiliation == "FIRST_ORDER" {
            cell.backgroundColor = UIColor(red: 220/255, green: 95/255, blue: 61/255, alpha: 0.5)
        } else if user.affiliation == "SITH" {
            cell.backgroundColor = UIColor(red: 252/255, green: 70/255, blue: 60/255, alpha: 0.5)
        }
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userDetailSegue", let indexPath = tableView.indexPathForSelectedRow {
            let user = UserController.shared.users[indexPath.row]
            guard let destinationVC = segue.destination as? UserDetailViewController else { return }
            destinationVC.user = user
        }
    }
}
