//
//  NewsTableViewController.swift
//  ClientVK
//
//  Created by d.molkov on 17.03.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    var vkServices = VKServicesProxy(vkServices: VKServices())
    var news: [NewsItem] = []
    var profiles: [NewsProfiles] = []
    var groups: [NewsGroups] = []
    var photoService: PhotoService?
    var nextFrom = ""
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()

        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.prefetchDataSource = self
        
        photoService = PhotoService(container: tableView)
        
        vkServices.loadNews() {[weak self] (news, profiles, groups, nextFrom) in
            self?.news = news
            self?.profiles = profiles
            self?.groups = groups
            self?.nextFrom = nextFrom
            self?.tableView.reloadData()
        }
        
        tableView.register(UINib(nibName: "HeaderNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderNewsTableViewCell")
        tableView.register(UINib(nibName: "TextNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "TextNewsTableViewCell")
        tableView.register(UINib(nibName: "FooterNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "FooterNewsTableViewCell")
        tableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotosTableViewCell")
    }
    
    // MARK: - Pull-to-refresh
    
    fileprivate func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "loading ...")
        refreshControl?.tintColor = .blue
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    @objc func refreshNews() {
        refreshControl?.beginRefreshing()
        let time = (news.first?.startTime) ?? ""
        vkServices.loadNews(time: time) {[weak self] (news, profiles, groups, nextFrom) in
            if news.count != 0 {
                let indexSet: IndexSet = IndexSet(integersIn: 0..<news.count)
                self?.news.insert(contentsOf: news, at: 0)
                self?.profiles.insert(contentsOf: profiles, at: 0)
                self?.groups.insert(contentsOf: groups, at: 0)
                self?.tableView.insertSections(indexSet, with: .automatic)
            }
            self?.refreshControl?.endRefreshing()
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if news[section].photos.count == 0 && news[section].text == "" {
            return 0
        }
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let header = tableView.dequeueReusableCell(withIdentifier: "HeaderNewsTableViewCell", for: indexPath) as! HeaderNewsTableViewCell
        let textNews = tableView.dequeueReusableCell(withIdentifier: "TextNewsTableViewCell", for: indexPath) as! TextNewsTableViewCell
        let photosNews = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
        let footer = tableView.dequeueReusableCell(withIdentifier: "FooterNewsTableViewCell", for: indexPath) as! FooterNewsTableViewCell
        
        switch indexPath.item {
            case 0:
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
            case 1:
                textNews.fullText = news[indexPath.section].text
                textNews.shortText = news[indexPath.section].shortText
                textNews.table = tableView
                textNews.indexPath = indexPath
                return textNews
            case 2:
                photosNews.aspectRatio = news[indexPath.section].aspectRatio
                photosNews.photos = news[indexPath.section].photos
                return photosNews
            default:
                footer.commentNumber.text = String(news[indexPath.section].comments)
                footer.likeNumber.text = String(news[indexPath.section].likes)
                footer.shareNumber.text = String(news[indexPath.section].reposts)
                return footer
        }
    }
}

//MARK: - Infinite Scrolling

extension NewsTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        if maxSection > news.count - 3,
           !isLoading {
            isLoading = true
            
            vkServices.loadNews(startFrom: self.nextFrom) {[weak self] (news, profiles, groups, nextFrom) in
                if news.count != 0 {
                    guard let self = self else { return }
                    let indexSet: IndexSet = IndexSet(integersIn: self.news.count..<(self.news.count + news.count))
                    self.news.append(contentsOf: news)
                    self.profiles.append(contentsOf: profiles)
                    self.groups.append(contentsOf: groups)
                    self.tableView.insertSections(indexSet, with: .automatic)
                    self.isLoading = false
                }
            }
        }
    }
}
