//
//  AllCommunitiesTableViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.02.2021.
//

import UIKit

class AllCommunitiesTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var search: UISearchBar!
    
    var allCommunities: [Communities] = Communities.fakeContent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CommunityTableViewCell", bundle: nil), forCellReuseIdentifier: "communitiesCell")
        
        search.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCommunities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "communitiesCell", for: indexPath) as! CommunityTableViewCell
        
        cell.label.text = allCommunities[indexPath.item].name
        cell.photo.imageName = allCommunities[indexPath.item].photo
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "unwindFormAllCommunities", sender: self)
    }
    
    // MARK: - Search bar data source
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        allCommunities = Communities.fakeContent.filter({community in
            return searchText != "" ? community.name.contains(searchText) :
                                    true
            
        })
        tableView.reloadData()
    }
}
