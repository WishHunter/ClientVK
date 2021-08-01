//
//  CommunitiesTableViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.02.2021.
//

import UIKit
import RealmSwift

class CommunitiesTableViewController: UITableViewController {

    var myGroups: Results<Group>?
    var vkServices = VKServicesProxy(vkServices: VKServices())
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CommunityTableViewCell", bundle: nil), forCellReuseIdentifier: "communitiesCell")
        vkServices.loadCommunities()
        realmObserve()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "communitiesCell", for: indexPath) as! CommunityTableViewCell
        guard let group = myGroups?[indexPath.item] else { return cell }
        cell.label.text = group.name
        cell.photo.imageName = URL(string: group.photo100 ?? "")
        
        return cell
    }
    
    //MARK: - SEGUE
    
    @IBAction func unwindFormAllCommunities(_ segue: UIStoryboardSegue) {
        
        guard let allCommunitiesContainer = segue.source as? AllCommunitiesTableViewController,
              let _ = allCommunitiesContainer.tableView.indexPathForSelectedRow
        else { return }
        
        vkServices.loadCommunities()
    }
}

//MARK: - RealmLoadData

extension CommunitiesTableViewController {
    func realmObserve() {
        guard let realm = try? Realm() else { return }
        myGroups = realm.objects(Group.self)
        
        token = myGroups?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self,
                  let tableView = self.tableView else { return }
            
            switch changes {
                case .initial:
                    tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    tableView.beginUpdates()
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    tableView.endUpdates()
                case .error(let error):
                    fatalError("\(error)")
            }
        }
    }
}
