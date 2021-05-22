//
//  FriendsTableViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 26.02.2021.
//

import UIKit

class FriendsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alphabetView: AlphabetPickerControl!
    
    var vkServices = VKServices()
    var users = [User]()
    var firstSymbols: [Character] = []
    var sortFriends: [Character: [User]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkServices.loadFriends() {[weak self] users in
            self?.users = users
            self?.alphabetView.letters = (self?.createFirstSimbols())!
            self?.firstSymbols = (self?.createFirstSimbols())!
            self?.sortFriends = (self?.sortUsers())!
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return sortFriends.count > 0 ? sortFriends.count : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstSymbols.count > 0 ? sortFriends[firstSymbols[section]]!.count : 0
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return firstSymbols.count > 0 ? String(firstSymbols[section]) : ""
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell
        let friend = sortFriends[firstSymbols[indexPath.section]]?[indexPath.item]
        
        cell.label.text = friend?.name
        
        if let photo = friend?.photo100 {
            let photoURL = URL(string: photo)
            cell.photo.imageName = photoURL
        }
                
        return cell
    }
  
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectFriend" {
            
            let photoToFriendController = segue.destination as! PhotoToFriendCollectionViewController

            if let indexPath = self.tableView.indexPathForSelectedRow {
                let friend = sortFriends[firstSymbols[indexPath.section]]?[indexPath.item]
                let name = friend?.name

                photoToFriendController.userId = friend?.id
                
                photoToFriendController.navigationItem.title = "\(String(name ?? "friend"))'s photos"
            }
        }
    }
    
    
    //MARK: - Action
    
    @IBAction func alphabetPickerValueChanged(_ sender: AlphabetPickerControl) {
        let section = firstSymbols.firstIndex(of: sender.selectedLetter ?? firstSymbols[0]) ?? 0
        
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: section), at: .top, animated: true)
    }
    
    @IBAction func avatarClicked(_ sender: AvatarViewControl) {
        avatarAnimation(sender)
    }
}

extension FriendsTableViewController {
    
    private func createFirstSimbols() -> [Character] {
        var setSimbols: Set<Character> = []
        users.forEach({ user in
            setSimbols.insert(user.name.first ?? " ")
        })
        
        return Array(setSimbols).sorted(by: {simbol, nextSimbol in return simbol < nextSimbol})
    }
    
    private func sortUsers() -> [Character: [User]] {
        var newUsers: [Character: [User]] = [:]
        
        firstSymbols.forEach({ simbol in
            newUsers[simbol] = users.filter({user in
                return user.name.first == simbol
            })
        })
        
        return newUsers
    }
}

//MARK: - Animation

extension FriendsTableViewController {
    private func avatarAnimation(_ elem: AvatarViewControl) {
        UIView.animate(withDuration: 0.2,
                       animations: {
                        elem.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                       },
                       completion: {_ in
                        self.avatarAnimationReturn(elem)
                       })
    }
    
    private func avatarAnimationReturn(_ elem: AvatarViewControl) {
        UIView.animate(withDuration: 0.3,
                       delay: 0.1,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0.2,
                       options: [.curveEaseInOut],
                       animations: {
                        elem.transform = .identity
                       },
                       completion: nil)
    }
}
