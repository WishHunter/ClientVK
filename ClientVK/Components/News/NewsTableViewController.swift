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
    var photoService: PhotoService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService = PhotoService(container: tableView)
        
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
        news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if news[section].attachments.count == 0 && news[section].text == "" {
            return 0
        } else if news[section].attachments.count == 0 || news[section].text == "" {
            return 3
        }
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let header = tableView.dequeueReusableCell(withIdentifier: "HeaderNewsTableViewCell", for: indexPath) as! HeaderNewsTableViewCell
        let textNews = tableView.dequeueReusableCell(withIdentifier: "TextNewsTableViewCell", for: indexPath) as! TextNewsTableViewCell
        let photosNews = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
        let footer = tableView.dequeueReusableCell(withIdentifier: "FooterNewsTableViewCell", for: indexPath) as! FooterNewsTableViewCell
        
        if indexPath.item == 0 {
            if news[indexPath.section].sourceId > 0 {
                let author = profiles.filter { profile in
                    profile.id == news[indexPath.section].sourceId
                }
                header.name.text = author[0].lastName + " " + author[0].firstName
                header.photo.imageName = URL(string: author[0].photo100)
            } else {
                let author = groups.filter { group in
                    group.id == abs(news[indexPath.section].sourceId)
                }
                header.name.text = author[0].name
                header.photo.imageName = URL(string: author[0].photo100)
            }
            header.date.text = news[indexPath.section].date
            
            return header
        }
        
        if news[indexPath.section].text != "" && news[indexPath.section].attachments.count != 0 {
            switch indexPath.item {
                case 1:
                    textNews.textNews.text = news[indexPath.section].text
                    return textNews
                case 2:
                    news[indexPath.section].photos.forEach { photoUrl in
                        guard let photo = photoService?.photo(atIndexpath: indexPath, byUrl: photoUrl) else { return }
                        photosNews.photos.append(photo)
                    }
                    return photosNews
                default:
                    footer.commentNumber.text = String(news[indexPath.section].comments)
                    footer.likeNumber.text = String(news[indexPath.section].likes)
                    footer.shareNumber.text = String(news[indexPath.section].reposts)
                    return footer
            }
        }
        
        switch indexPath.item {
            case 1:
                if news[indexPath.section].text != "" {
                    textNews.textNews.text = news[indexPath.section].text
                    return textNews
                } else {
                    news[indexPath.section].photos.forEach { photoUrl in
                        guard let photo = photoService?.photo(atIndexpath: indexPath, byUrl: photoUrl) else { return }
                        photosNews.photos.append(photo)
                    }
                    return photosNews
                }
            default:
                footer.commentNumber.text = String(news[indexPath.section].comments)
                footer.likeNumber.text = String(news[indexPath.section].likes)
                footer.shareNumber.text = String(news[indexPath.section].reposts)
                return footer
        }
    }
}
