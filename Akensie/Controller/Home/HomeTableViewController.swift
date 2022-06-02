//
//  HomeTableViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 05/01/2021.
//  Copyright © 2021 Gideon Bedzrah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseMessaging

class HomeTableViewController: UIViewController, PopupDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    var path: [DocumentReference]!
    var posts = [NewPosts]()
    var users = [Users]()
    var postCell = [PostCell]()
    var docID: String?
//    let userDefaults = UserDefaults.standard
    let gcmMessageIDKey = "gcm.Message_ID"
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var pleaseWaitLabel: UILabel!
    @IBOutlet weak var pleaseActivity: UIActivityIndicatorView!
        
    var followingState = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var questions = [NewQuestion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if !defaults.bool(forKey: "Welcome"){
//            Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(openAlert), userInfo: nil, repeats: false)
//        }
        
        refreshControl.isEnabled = true
        refreshControl.addTarget(self, action: #selector(retrieveFollowersPost), for: .valueChanged)
//        retrieveUserPosts()
        tableView.addSubview(refreshControl)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if Auth.auth().currentUser == nil {
            self.doneLoading()
        }else {
            retrieveFollowersPost()
            registerForNotification(UIApplication.shared)
            updateFirestorePushTokenIfNeeded()
        }
        GameScores.totalScore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func registerForNotification(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
    }
    func updateFirestorePushTokenIfNeeded() {
        if let userID = defaults.string(forKey: "documentID") {
            if let token = Messaging.messaging().fcmToken {
                 Firestore.firestore()
                    .collection("users").document(userID).collection("notifications").document("notificationToken").setData(["fcmToken" : token])
            }
        }
    }

    
    func doneLoading() {
        loadingView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        if pleaseWaitLabel != nil && pleaseActivity != nil && loadingView != nil {
            pleaseWaitLabel.removeFromSuperview()
            pleaseActivity.removeFromSuperview()
            loadingView.removeFromSuperview()
            tableView.reloadData()
        }
    }
    
    var dID: String?
    @objc func retrieveUserPosts() {
        
        db.collection("posts").order(by: "time", descending: true).addSnapshotListener { (snapshot, error) in
            
            self.posts = []
            if let err = error {
                print("error: \(err.localizedDescription)")
            }else {
            
                if let snap = snapshot?.documents{
                    for doc in snap {
                        
                        let result = Result {
                            try doc.data(as: NewPosts.self)
                           }
                           switch result {
                           case .success(let posts):
                            
                               if let posts = posts {
                                print("some: \(posts)")
                                self.posts.append(NewPosts(title: posts.title, caption: posts.caption, time: posts.time, image: posts.image, posterID: posts.posterID, likesCount: posts.likesCount, postID: posts.postID, playsCount: posts.playsCount, userfullname: posts.userfullname, userUsername: posts.userUsername, playOnce: posts.playOnce, questions: posts.questions))
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            
                               } else {
                                   print("Document does not exist")
                               }
                           case .failure(let error):
                        
                               print("Error decoding city: \(error)")
                           }
                        
                    }
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
   @objc func retrieveFollowersPost() {
    if let userID = defaults.string(forKey: "documentID"){
        db.collection("users").document(userID).collection("following")
            .addSnapshotListener { [self] (snapshot, error) in
            self.posts = []
            if let _ = error {
            }else {
                if let doc = snapshot?.documents {
                    
                    if doc.isEmpty {
                        followingState = 1
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        self.refreshControl.endRefreshing()
                        print("hello this is cell")
                        return
                    }
                    self.posts = []
                    for d in doc {
                        
                        let ID =  d.documentID
                        db.collection("posts").whereField("posterID", isEqualTo: ID).getDocuments { (snapshot, error) in
                            
                            
                            if let err = error {
                                print("error: \(err.localizedDescription)")
                            }else {
                                if let snap = snapshot?.documents{
                                    if snap.isEmpty {
                                        followingState = 2
                                        
                                        print("hello this is not cell")
                                    }
                                    for doc in snap {

                                        let result = Result {
                                            try doc.data(as: NewPosts.self)
                                           }
                                           switch result {
                                           case .success(let posts):
                                            
                                               if let posts = posts {
//                                                followingState = 0
                                                self.posts.append(NewPosts(title: posts.title, caption: posts.caption, time: posts.time, image: posts.image, posterID: posts.posterID, likesCount: posts.likesCount, postID: posts.postID, playsCount: posts.playsCount, userfullname: posts.userfullname, userUsername: posts.userUsername, playOnce: posts.playOnce, questions: posts.questions))
                                                
                                                DispatchQueue.main.async {

                                                    self.tableView.reloadData()
                                                }

                                               } else {
                                                   print("Document does not exist")
                                               }
                                           case .failure(let error):

                                               print("Error decoding city: \(error)")
                                           }

                                    }
//                                    posts.removeDuplicates()
                                    posts.sort(by: {$0.time > $1.time})
                                    if !posts.isEmpty{
                                    followingState = 0
                                    }
                                    self.refreshControl.endRefreshing()
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
   }
    }
    
    
   
    
    
    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Auth.auth().currentUser != nil {
            if followingState == 0 {
                performSegue(withIdentifier: "toGameDetails", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toGameDetails" {
            let indexPath = tableView.indexPathForSelectedRow
            let destinationVC = segue.destination as! GameDetailsViewController
            destinationVC.post = posts[indexPath!.row]
        }
        
        if segue.identifier == "toProfile" {
            let destinationVC = segue.destination as! UserDetailsViewController
            destinationVC.docID = defaults.string(forKey: "documentID")
            destinationVC.retrievedName = defaults.string(forKey: "full name")
            destinationVC.retrievedUsername = defaults.string(forKey: "username")
            destinationVC.retrievedScore = String(defaults.integer(forKey: "score"))
            destinationVC.userDetails = "This is Akensie's source code baby"
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if Auth.auth().currentUser != nil {
            if followingState == 0 {
        return self.posts.count
            }else {
                return 1
            }
        }else {
            return 1
        }
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if Auth.auth().currentUser != nil {
            if followingState == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! PostedQuestionsCell

        let postIndex = self.posts[indexPath.row]
        cell.fullnameLabel.text = postIndex.userfullname
        cell.usernameLabel.text = postIndex.userUsername
        
        cell.postTitle.text = postIndex.title
        cell.postCaption.text = postIndex.caption
        
        cell.numberOfQuestions.text = "\(postIndex.questions.count) questions"
        cell.timeStamp.text = postIndex.time.timeAgoDisplay()
        cell.selfDelegate = true
        if let url = URL(string: postIndex.image){
            cell.postImage.loadImage(from: url)
            self.doneLoading()
        }
        
        return cell
            }else if followingState == 1 {
               let cell = tableView.dequeueReusableCell(withIdentifier: "noFollowing", for: indexPath)
                self.doneLoading()
                return cell
            }else {
                self.doneLoading()
                return tableView.dequeueReusableCell(withIdentifier: "noPosts", for: indexPath)
            }
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "noSignIn", for: indexPath)
        
        }
    }
    
    @IBAction func postNewGameTapped(_ sender: UIButton) {
        NewGameTapped()
    }
    
    func NewGameTapped() {

        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "toPostNewGame", sender: self)
        }else {
            let alert = UIAlertController(title: "Post a New Game", message: "Earn up to 200 xp on each post", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Sign-In", style: .default, handler: { [self] (_) in
                
                cacheImage.removeAllObjects()
                
                let hVC = self.storyboard?.instantiateViewController(identifier: "SplashScreen")
                self.view.window?.rootViewController = hVC
                self.view.window?.makeKeyAndVisible()
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }

// functions
    
    @objc func openAlert() {
        var MYpopupView:PopupViewController!
        MYpopupView = PopupViewController(nibName:"PopupViewController", bundle: nil)
        self.view.alpha = 1.0
        MYpopupView.closePopup = self
        self.presentpopupViewController(popupViewController: MYpopupView, animationType: .TopTop, completion: {() -> Void in
        })
        
    }
    func closeTapped() {
        self.dismissPopupViewController(animationType: SLpopupViewAnimationType.Fade)
    }
    
    


}

//extension HomeTableViewController: UNUserNotificationCenterDelegate {
//    
//    
//}

@available(iOS 10, *)
extension HomeTableViewController: UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)

    completionHandler()
  }
}
