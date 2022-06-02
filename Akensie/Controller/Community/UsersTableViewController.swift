//
//  UsersTableViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 23/12/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class UsersTableViewController: UITableViewController, UISearchControllerDelegate {

    let searchController = UISearchController(searchResultsController: nil)
    var searchedName = [LeaderboardModel]()
    let db = Firestore.firestore()
    var ranking = [LeaderboardModel]()
    let storage = Storage.storage()
    var cachedImage: UIImage?
    var docID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        refreshControl?.isEnabled = false
        if Auth.auth().currentUser != nil {
            retrieveLeaderboard()
            refreshControl?.isEnabled = true
            refreshControl?.addTarget(self, action: #selector(retrieveLeaderboard), for: .valueChanged)
            GameScores.totalScore()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.tintColor = .label
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.barTintColor = .none
        
    }
    
    @objc func retrieveLeaderboard() {
        db.collection("users").order(by: "score", descending: true).addSnapshotListener { (snapshot, error) in
            
            self.ranking = []
            if let err = error {
                print("error loading leaderboard: \(err.localizedDescription)")
            } else {
                if let qss = snapshot?.documents {
                    var rank = 0
                    for doc in qss {
                        
                        if let retrievedName = doc.data()["full name"] as? String, let retrievedScore = doc.data()["score"] as? Int, let retrievedUsername = doc.data()["username"] as? String, let retrievedPic = doc.data()["profilePic"] as? String{
                            DispatchQueue.main.async {
                                rank += 1
                                self.ranking.append(LeaderboardModel(name: retrievedName, username: retrievedUsername, score: retrievedScore, pic: retrievedPic, docId: doc.documentID, position: rank))
                                
                                print("new: \(rank)")
                               
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                                
                            }
                        }
                    }
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }

    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    var searching = false
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if Auth.auth().currentUser != nil {
            if !searching {
        return ranking.count
            }else{
                return searchedName.count
            }
        } else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Auth.auth().currentUser != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserViewCell
            cell.userID = defaults.string(forKey: "documentID")
            
            if !searching {
            cell.fullname.text = ranking[indexPath.row].name
            cell.username.text = ranking[indexPath.row].username
            cell.scoreLabel.text = "\(ranking[indexPath.row].score)"
            cell.totalPositionLabel.text = "of \(ranking.count)"
            cell.positionLabel.text = String(ranking[indexPath.row].position)
                cell.docID = ranking[indexPath.row].docId
                cell.profileImage.loadMetaImage(from: ranking[indexPath.row].pic)
            defaults.set(ranking[indexPath.row].docId, forKey: "documentID\(indexPath.row)")
        
            }else {
                cell.profileImage.image = UIImage(named: "IconProfile")
                cell.fullname.text = searchedName[indexPath.row].name
                cell.username.text = searchedName[indexPath.row].username
                cell.scoreLabel.text = "\(searchedName[indexPath.row].score)"
                cell.totalPositionLabel.text = "of \(ranking.count)"
                cell.positionLabel.text = String(searchedName[indexPath.row].position)
                cell.docID = searchedName[indexPath.row].docId
                defaults.set(searchedName[indexPath.row].docId, forKey: "documentID\(indexPath.row)")
                cell.profileImage.loadMetaImage(from: searchedName[indexPath.row].pic)
                
            }
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "noSignIn", for: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Auth.auth().currentUser != nil {
        performSegue(withIdentifier: "toUserDetails", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUserDetails" {
            let destinationVC = segue.destination as! UserDetailsViewController
            if !searching {
            let indexPath = tableView.indexPathForSelectedRow
            destinationVC.ranking = ranking[indexPath!.row]
            destinationVC.path = ranking[indexPath!.row].pic
            destinationVC.position = indexPath!.row + 1
            destinationVC.totalPosition = ranking.count
            destinationVC.docID = defaults.string(forKey: "documentID\(indexPath!.row)")
            }else {
                let indexPath = tableView.indexPathForSelectedRow
                destinationVC.ranking = searchedName[indexPath!.row]
                destinationVC.path = searchedName[indexPath!.row].pic
                destinationVC.position = searchedName[indexPath!.row].position
                destinationVC.totalPosition = ranking.count
                destinationVC.docID = defaults.string(forKey: "documentID\(indexPath!.row)")
            }
        }
    }

}

extension UsersTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedName = ranking.filter({$0.name.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        tableView.reloadData()
    }

    
}
