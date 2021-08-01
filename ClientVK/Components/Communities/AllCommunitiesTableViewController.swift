//
//  AllCommunitiesTableViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.02.2021.
//

import UIKit
import FirebaseDatabase

class AllCommunitiesTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var search: UISearchBar!
    
    var allGroups = [Group]()
    var vkServices = VKServicesProxy(vkServices: VKServices())
    
    private let ref = Database.database().reference(withPath: "authUser")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CommunityTableViewCell", bundle: nil), forCellReuseIdentifier: "communitiesCell")
        
        search.delegate = self
        
        vkServices.searchCommunities() {[weak self] groups in
            self?.allGroups = groups
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "communitiesCell", for: indexPath) as! CommunityTableViewCell
        
        cell.label.text = allGroups[indexPath.item].name
        cell.photo.imageName = URL(string: allGroups[indexPath.item].photo100 ?? "")
        
        return cell
    }
    
    // MARK: - Search bar data source
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText != "" ? searchText : " "
        vkServices.searchCommunities(stroke: text) {[weak self] groups in
            self?.allGroups = groups
            self?.tableView.reloadData()
        }
    }
}
