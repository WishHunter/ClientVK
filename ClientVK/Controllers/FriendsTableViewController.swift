//
//  FriendsTableViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 26.02.2021.
//

import UIKit

class FriendsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alphabetView: AlphabetPicker!
    
    var vkServices = VKServices()
    
    var friends: [User] = User.fakeContent
    var firstSymbols: [Character]!
    var sortFriends: [Character: [User]]!

    override func viewDidLoad() {
        super.viewDidLoad()
        alphabetView.letters = createFirstSimbols()
        firstSymbols = createFirstSimbols()
        sortFriends = sortUsers()
        
        vkServices.loadFriends()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return sortFriends.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortFriends[firstSymbols[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(firstSymbols[section])
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell
        let friend = sortFriends[firstSymbols[indexPath.section]]?[indexPath.item]
        
        cell.label.text = friend?.name
        
        if let photo = friend?.photo {
            cell.photo.imageName = photo
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

                
                photoToFriendController.user = friend
                
                photoToFriendController.navigationItem.title = "\(String(name ?? "friend"))'s photos"
            }
        }
    }
    
    
    //MARK: - Action
    
    @IBAction func alphabetPickerValueChanged(_ sender: AlphabetPicker) {
        let section = firstSymbols.firstIndex(of: sender.selectedLetter ?? firstSymbols[0]) ?? 0
        
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: section), at: .top, animated: true)
    }
    
    @IBAction func avatarClicked(_ sender: AvatarView) {
        avatarAnimation(sender)
    }
}

extension FriendsTableViewController {
    
    private func createFirstSimbols() -> [Character] {
        var setSimbols: Set<Character> = []
        friends.forEach({ friend in
            setSimbols.insert(friend.name.first ?? " ")
        })
        
        return Array(setSimbols).sorted(by: {simbol, nextSimbol in return simbol < nextSimbol})
    }
    
    private func sortUsers() -> [Character: [User]] {
        var newUsers: [Character: [User]] = [:]
        
        firstSymbols.forEach({ simbol in
            newUsers[simbol] = friends.filter({friend in
                return friend.name.first == simbol
            })
        })
        
        return newUsers
    }
}

//MARK: - Animation

extension FriendsTableViewController {
    private func avatarAnimation(_ elem: AvatarView) {
        UIView.animate(withDuration: 0.2,
                       animations: {
                        elem.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                       },
                       completion: {_ in
                        self.avatarAnimationReturn(elem)
                       })
    }
    
    private func avatarAnimationReturn(_ elem: AvatarView) {
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
