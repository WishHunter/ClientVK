//
//  NewsTableViewController.swift
//  ClientVK
//
//  Created by d.molkov on 17.03.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var vkServices = VKServices()
    var news: [NewsItem] = []
    var profiles: [NewsProfiles] = []
    var groups: [NewsGroups] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkServices.loadNews() {[weak self] (news, profiles, groups) in
            self?.news = news
            self?.profiles = profiles
            self?.groups = groups
            self?.tableView.reloadData()
        }
        
        tableView.register(UINib(nibName: "HeaderNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderNewsTableViewCell")
        tableView.register(UINib(nibName: "TextNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "TextNewsTableViewCell")
        tableView.register(UINib(nibName: "FooterNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "FooterNewsTableViewCell")
        tableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotosTableViewCell")
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let header = tableView.dequeueReusableCell(withIdentifier: "HeaderNewsTableViewCell", for: indexPath) as! HeaderNewsTableViewCell
        let textNews = tableView.dequeueReusableCell(withIdentifier: "TextNewsTableViewCell", for: indexPath) as! TextNewsTableViewCell
        let photosNews = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
        let footer = tableView.dequeueReusableCell(withIdentifier: "FooterNewsTableViewCell", for: indexPath) as! FooterNewsTableViewCell
                
        switch indexPath.item {
        case 0:
            return header
        case 1:
            return textNews
        case 2:
            return photosNews
        default:
            return footer
        }
    }
}
