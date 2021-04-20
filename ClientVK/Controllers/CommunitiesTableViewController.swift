//
//  CommunitiesTableViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.02.2021.
//

import UIKit

class CommunitiesTableViewController: UITableViewController {

    var myGroups = [Group]()
    var vkServices = VKServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CommunityTableViewCell", bundle: nil), forCellReuseIdentifier: "communitiesCell")
        
        vkServices.loadCommunities() {[weak self] groups in
            self?.myGroups = groups
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "communitiesCell", for: indexPath) as! CommunityTableViewCell
        
        cell.label.text = myGroups[indexPath.item].name
        cell.photo.imageName = myGroups[indexPath.item].photo_100
        
        return cell
    }
    
    //MARK: - SEGUE
    
    @IBAction func unwindFormAllCommunities(_ segue: UIStoryboardSegue) {
        
        guard let allCommunitiesContainer = segue.source as? AllCommunitiesTableViewController,
              let _ = allCommunitiesContainer.tableView.indexPathForSelectedRow
        else { return }
        
        vkServices.loadCommunities() {[weak self] groups in
            self?.myGroups = groups
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.myCommunities.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
    }
}
