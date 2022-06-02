//
//  ScoresViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 24/12/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ScoresViewController: UIViewController {
    
    let db = Firestore.firestore()
    var scoreBreakdown = [ScoreBreakdown]()
    var docID: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveScores()
    }
    
    func retrieveScores() {
        if let docID = self.docID {
         let somePath = db.collection("users").document(docID)
            somePath.collection("scoreManager").addSnapshotListener{ [self] (snapshot, error) in
                if let err = error {
                    print("error retrieving achievemnt: \(err.localizedDescription)")
                }else {
                    if let qss = snapshot?.documents {
                        for doc in qss {
                            
                            if doc.documentID != "Bonus" {
                                if doc.documentID != "General" {
                                    print("hello: \(doc.data())")
                                    print("hello: \(doc.documentID)")
                                    
                                    let easy = doc.data()["easy"] as! Int
                                    let medium = doc.data()["medium"] as! Int
                                    let hard = doc.data()["hard"] as! Int
                                    let name = doc.documentID
                                    
                                    self.scoreBreakdown.append(ScoreBreakdown(subject: name, easy: easy, medium: medium, Hard: hard))
                                }
                            }
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                        
                    }
                }
                
            }
            somePath.collection("scores").getDocuments { (snap, er) in
                if let e = er {
                    print(e)
                }else {
                    if let qs = snap?.documents {
                        if qs.isEmpty {return}
                        for d in qs {
                           let postName = d.data()["postName"] as? String
                            let gameScore = d.data()["GameScore"] as! Int
                            self.scoreBreakdown.append(ScoreBreakdown(subject: d.documentID, easy: gameScore, medium: 0, Hard: 0))
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                    
                }
            }
        }
    }

}

extension ScoresViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreBreakdown.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoresTable", for: indexPath) as! ScoresTableViewCell
        
         let score = self.scoreBreakdown[indexPath.row]
            cell.subjectName.text = score.subject
            cell.easyScore.text = String(score.easy)
            cell.mediumScore.text = String(score.medium)
            cell.hardScore.text = String(score.Hard)
        
        
        return cell
    }
}
