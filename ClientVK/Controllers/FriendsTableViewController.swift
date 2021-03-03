//
//  FriendsTableViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 26.02.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var friends: [User] = User.fakeContent

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell
        let friend = friends[indexPath.item]
        
        cell.label.text = friend.name
        
        if let photo = friend.photo {
            cell.photo.imageName = photo
        }
                
        return cell
    }
    
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectFriend" {
            
            let photoToFriendController = segue.destination as! PhotoToFriendCollectionViewController

            if let indexPath = self.tableView.indexPathForSelectedRow {
                let name = self.friends[indexPath.item].name


                photoToFriendController.navigationItem.title = "\(name)'s photos"
            }
        }
    }
}
