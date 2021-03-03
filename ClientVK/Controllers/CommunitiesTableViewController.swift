//
//  CommunitiesTableViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.02.2021.
//

import UIKit

class CommunitiesTableViewController: UITableViewController {

    var myCommunities = [
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 11"],
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 12"],
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 13"],
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 14"],
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 15"],
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 16"],
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCommunities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "communitiesCell", for: indexPath) as! CommunitiesTableViewCell
        
        cell.label.text = myCommunities[indexPath.item][1]
        
        let imgURL: NSURL = NSURL(string: myCommunities[indexPath.item][0])!
        let imgData: NSData = NSData(contentsOf: imgURL as URL)!
        cell.photo.image = UIImage(data: imgData as Data)
        
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
            let allCommunies = allCommunitiesContainer.allCommunities.filter({communite in
                var communiteRepeat = false
                
                for myCommunite in self.myCommunities {
                    if myCommunite == communite {
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
