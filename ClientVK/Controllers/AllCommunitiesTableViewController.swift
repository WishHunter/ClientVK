//
//  AllCommunitiesTableViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.02.2021.
//

import UIKit

class AllCommunitiesTableViewController: UITableViewController {

    var allCommunities = [
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 1"],
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 2"],
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 3"],
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 4"],
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 5"],
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 15"],
        ["https://static.probusiness.io/720x480c/n/03/d/38097027_439276526579800_2735888197547458560_n.jpg", "сообщество 6"],
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCommunities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "communitiesCell", for: indexPath) as! AllCommunitiesTableViewCell
        
        cell.label.text = allCommunities[indexPath.item][1]
        
        let imgURL: NSURL = NSURL(string: allCommunities[indexPath.item][0])!
        let imgData: NSData = NSData(contentsOf: imgURL as URL)!
        cell.photo.image = UIImage(data: imgData as Data)
        
        return cell
    }
}
