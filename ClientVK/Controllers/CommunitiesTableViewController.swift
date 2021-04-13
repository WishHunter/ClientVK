//
//  CommunitiesTableViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.02.2021.
//

import UIKit

class CommunitiesTableViewController: UITableViewController {

    var myCommunities: [Communities] = []
    var vkServices = VKServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CommunityTableViewCell", bundle: nil), forCellReuseIdentifier: "communitiesCell")
        
        vkServices.loadCommunities()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCommunities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "communitiesCell", for: indexPath) as! CommunityTableViewCell
        
        cell.label.text = myCommunities[indexPath.item].name
        cell.photo.imageName = myCommunities[indexPath.item].photo
        
        return cell
    }
    
    //MARK: - SEGUE
    
    @IBAction func unwindFormAllCommunities(_ segue: UIStoryboardSegue) {
        
        guard let allCommunitiesContainer = segue.source as? AllCommunitiesTableViewController,
              let indexCell = allCommunitiesContainer.tableView.indexPathForSelectedRow
        else { return }
        
        let communite = allCommunitiesContainer.allCommunities[indexCell.item]
        myCommunities.append(communite)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "myComToAlCom" {
            let allCommunitiesContainer = segue.destination as! AllCommunitiesTableViewController
            let allCommunies = allCommunitiesContainer.allCommunities.filter({community -> Bool in
                var communiteRepeat = false
                
                for myCommunity in self.myCommunities {
                    if myCommunity.name == community.name {
                        communiteRepeat = true
                    }
                }
                return !communiteRepeat
            })
          
            allCommunitiesContainer.allCommunities = allCommunies
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.myCommunities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
