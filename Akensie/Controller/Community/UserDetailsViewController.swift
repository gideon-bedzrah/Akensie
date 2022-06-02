//
//  UserDetailsViewController.swift
//  Akensie
//
//  Created by Gideon Bedzrah on 23/12/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

class UserDetailsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var totalPositionLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var achievementsScoreLabel: UILabel!
    
    @IBOutlet weak var achievementsView: UIView!
    
    @IBOutlet weak var scoreView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var noPostsLabel: UILabel!
    
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var secondViewAllButton: UIButton!
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var recentPostLabel: UILabel!
    @IBOutlet weak var editPostButton: UIButton!
    
    
    
    var retrievedName: String?
    var retrievedUsername: String?
    var retrievedScore: String?
    
    let storage = Storage.storage()
    let db = Firestore.firestore()
    var ranking: LeaderboardModel?
    var position: Int?
    var totalPosition: Int?
    var docID: String?
    let userID = defaults.string(forKey: "documentID")
    
    var userDetails: String?
    var noProfileImage: Bool?
    
    var path: String?
    var show: Bool = false
    
    var posts = [NewPosts]()
    var rtP: RecentPostCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        viewAllButton.isHidden = true
        if docID == userID {
            logoutButton.isHidden = false
            profileImage.loadMetaImage(from: defaults.string(forKey: "profilePic")!)
            //use a delegate protocol.
            if profileImage.image != UIImage(named: "IconProfile") {
                noProfileImage = true
            }else {
                noProfileImage = false
            }
            editPostButton.isHidden = false
            recentPostLabel.text = "My Recent Posts"
            
        }
        
        followButton.setImage(UIImage(systemName: "person.crop.circle.badge.plus"), for: .normal)
        followButton.setTitle(" Follow", for: .normal)
        followButton.setImage(UIImage(systemName: "person.crop.circle.fill.badge.checkmark"), for: .selected)
        followButton.setTitle(" Following", for: .selected)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        scoreView.alpha = 0
        
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        
        if let rn = ranking {
        fullNameLabel.text = rn.name
        usernameLabel.text = rn.username
        
        scoreLabel.text = "\(rn.score)"
        }
        
        
        if let p = position {
            positionLabel.text = "\(p)"
        }
        
        if let tP = totalPosition {
            totalPositionLabel.text = "of \(tP)"
        }
        
        if let p = path {
            self.profileImage.loadMetaImage(from: p)
        }

        
        if let _ = userDetails {
            fullNameLabel.text = retrievedName
            usernameLabel.text = retrievedUsername
            scoreLabel.text = retrievedScore
        
        }
        
        retrievePosts()
        checkFollowing()
    }
    
    func retrievePosts() {
        guard let d = docID else {return}
        db.collection("posts").whereField("posterID", isEqualTo: d).getDocuments { [self] (snapshot, error) in
            if let _ = error {
                
            }else {
                if let snap = snapshot?.documents{
                    if snap.isEmpty {
                        noPostsLabel.isHidden = false
                        activity.isHidden = true
                        editPostButton.isHidden = true
                        secondViewAllButton.isHidden = true
                    }
                    for doc in snap {
                        
                        let result = Result {
                            try doc.data(as: NewPosts.self)
                           }
                           switch result {
                           case .success(let posts):
                            
                               if let posts = posts {
                            
                                self.posts.append(NewPosts(title: posts.title, caption: posts.caption, time: posts.time, image: posts.image, posterID: posts.posterID, likesCount: posts.likesCount, postID: posts.postID, playsCount: posts.playsCount, userfullname: posts.userfullname, userUsername: posts.userUsername, playOnce: posts.playOnce, questions: posts.questions))
                                
                                activity.isHidden = true
                                DispatchQueue.main.async {
                                    self.collectionView.reloadData()
                                }
                            
                               } else {
                                   print("Document does not exist")
                               }
                           case .failure(let error):
                        
                               print("Error decoding city: \(error)")
                           }
                        
                    }
                    posts.sort(by: {$0.time > $1.time})
                    
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func checkFollowing() {
        if docID != userID {
        db.collection("users").document(docID!).collection("followers").addSnapshotListener { (snapshot, error) in
            if let _ = error {
                
            }else {
                if let snap = snapshot {
                    for s in snap.documents {
                        if s.documentID == self.userID {
                            self.followButton.isSelected = true
                        }
                    }
                }
            }
        }
        } else {
            followButton.setTitle("Edit profile", for: .normal)
            followButton.setImage(UIImage(), for: .normal)
            followButton.setTitleColor(.systemBlue, for: .normal)
            viewAllButton.isHidden = false
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toachvc" {
            let achVC = segue.destination as! UserAchViewController
            achVC.docID = self.docID
        }
        
        if segue.identifier == "toscorevc" {
            let scorevc = segue.destination as! ScoresViewController
            scorevc.docID = self.docID
        }
        
        if segue.identifier == "toGameDetails"{
            let destinationVC = segue.destination as! GameDetailsViewController
            let indexPath = collectionView.indexPathsForSelectedItems?[0]
            destinationVC.post = posts[indexPath!.row]
        }
        
        if segue.identifier == "toGamesPlayed" {
            let destinationVC = segue.destination as! GamesPlayedViewController
            destinationVC.docID = self.docID
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.barTintColor = .none
        
        navigationController?.navigationBar.isHidden = false
        
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let logoutAction = UIAlertAction(title: "Yes", style: .default) { (logout) in
                cacheImage.removeObject(forKey: "userProfilePic")
                cacheImage.removeAllObjects()
            defaults.removeObject(forKey: "full name")
            defaults.removeObject(forKey: "score")
                let firebaseAuth = Auth.auth()
                
                do {
                  try firebaseAuth.signOut()
                } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
                }
        }
        alert.addAction(logoutAction)
        self.present(alert, animated: true, completion: nil)
        
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addFriendTapped(_ sender: UIButton) {
        if sender.currentTitle != "Edit profile" {
        
        sender.isSelected = !sender.isSelected
        
            if defaults.bool(forKey: "Haptics") {
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            }
        if sender.isSelected {
            
            db.collection("users").document(docID!).collection("followers").document(userID!).setData(["userRef" : userID!]){ [self] (error) in
                if let _ = error {
                    sender.isSelected = false
                    self.view.showToast(toastMessage: "Sorry, an error occured", duration: 2.0)
                }else{
                  let abc = db.collection("users").document(userID!).collection("following")
                    
                        abc.document(docID!).setData(["userRef" : docID!]){
                        (error) in
                            if let _ = error {
                                sender.isSelected = false
                                self.view.showToast(toastMessage: "Sorry, an error occured", duration: 2.0)
                            }else{
                                self.view.showToast(toastMessage: "You are now following", duration: 2.0)
                                abc.document(userID!).setData(["userRef" : userID!])
                            }
                    }
                }
        }
        }else {
            db.collection("users").document(docID!).collection("followers").document(userID!).delete() { [self] (error) in
                if let _ = error {
                    sender.isSelected = true
                    self.view.showToast(toastMessage: "Sorry, an error occured", duration: 2.0)
                }else {
                    db.collection("users").document(userID!).collection("following").document(docID!).delete(){
                        (error) in
                            if let _ = error {
                                sender.isSelected = true
                                self.view.showToast(toastMessage: "Sorry, an error occured", duration: 2.0)
                            }else{
                                self.view.showToast(toastMessage: "You are no longer following", duration: 2.0)
                            }
                    }
                }
            }
        }
        } else {

            let alert = UIAlertController(title: "choose an option below", message: nil, preferredStyle: .actionSheet)
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Profile image", style: .default, handler: { (_) in

                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Personal information", style: .destructive, handler: { (_) in
                self.performSegue(withIdentifier: "toEditProfile", sender: self)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
     
    @IBAction func editButtonTapped(_ sender: UIButton) {
        if sender.currentTitle == "Edit" {
            show = true
            collectionView.reloadData()
            sender.setTitle("Done", for: .normal)
        }else {
            show = false
            collectionView.reloadData()
            sender.setTitle("Edit", for: .normal)
        }
        
    }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
            
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                 profileImage.image = editedImage
    
            }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                profileImage.image = originalImage
            }
            
            if let imageToUplaod = profileImage.image?.jpegData(compressionQuality: 0.75){
                uploadImage(imageToUplaod)
                if profileImage.image != nil {
                    cacheImage.setObject(profileImage.image!, forKey: NSString(string: "userProfilePic"))
                }
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        
    func uploadImage(_ imageData: Data) {

        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"

        if let user = Auth.auth().currentUser?.uid {
            storage.reference(withPath: "ProfileImage/\(user).jpeg").putData(imageData, metadata: uploadMetadata) { (downloadMeta, error) in
                if let err = error {
                    print("Error uploading image: \(err.localizedDescription)")
                }else {
                    print("image upload successfull!: \(String(describing: downloadMeta))")
                    if let meta = downloadMeta?.name{
                        if let docID = defaults.string(forKey: "documentID") {
                            self.db.collection("users").document("\(docID)").updateData(["profilePic" : meta]){ err in
                                if let err = err {
                                    print("Error updating document: \(err)")
                                } else {
                                    print("Document successfully updated")
                                    
                                    let alert = UIAlertController(title: "🎉 New achievement unlocked!", message: "Shiny New Look has now been unlocked. You set a new profile image.", preferredStyle: .alert)
                                    
                                    UserAchievements.allAchievements(name: "newProfile")
                                    
                                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                                    
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                    
                    
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func segementedControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            achievementsScoreLabel.text = "Achievements"
            achievementsView.alpha = 1
            scoreView.alpha = 0
            if docID == userID {
                viewAllButton.isHidden = false
            }
        }else {
            achievementsScoreLabel.text = "Score"
            achievementsView.alpha = 0
            scoreView.alpha = 1
            viewAllButton.isHidden = true
        }
        
    }
    
    @IBAction func viewAllButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toGamesPlayed", sender: self)
    }
}

extension UserDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedGamesCell", for: indexPath) as! RecentPostCell
        rtP = cell
        rtP!.delegate = self
        let postIndex = posts[indexPath.row]
        cell.postTitle.text = postIndex.title
        if let url = URL(string: postIndex.image){
            cell.postImage.loadImage(from: url)
        }
        cell.show = self.show
        cell.postID = postIndex.postID
        cell.postName = postIndex.title
        cell.indexPath = indexPath
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let _ = self.collectionView.frame
        return CGSize(width: 133, height: 167)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toGameDetails", sender: self)
    }
    
    
}
extension UserDetailsViewController: deletePostProtocol {
    func deleteSuccessfull(_ indexPath: IndexPath) {
        posts.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
        self.collectionView.reloadData()
        self.view.showToast(toastMessage: "Post deleted successfully.", duration: 2.0)
    }
    

    
    func deletefailed() {
        collectionView.reloadData()
        self.view.showToast(toastMessage: "Oops! an error occured could not delete post.", duration: 2.0)
    }
    
    
}



//MARK: Add Toast method function in UIView Extension so can use in whole project.
extension UIView
{
func showToast(toastMessage:String,duration:CGFloat)
{
//View to blur bg and stopping user interaction
let bgView = UIView(frame: self.frame)
bgView.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(255.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(0.6))
bgView.tag = 555

//Label For showing toast text
let lblMessage = UILabel()
lblMessage.numberOfLines = 0
lblMessage.lineBreakMode = .byWordWrapping
lblMessage.textColor = .white
lblMessage.backgroundColor = .black
lblMessage.textAlignment = .center
lblMessage.font = UIFont.init(name: "Helvetica Neue", size: 17)
lblMessage.text = toastMessage

//calculating toast label frame as per message content
let maxSizeTitle : CGSize = CGSize(width: self.bounds.size.width-16, height: self.bounds.size.height)
var expectedSizeTitle : CGSize = lblMessage.sizeThatFits(maxSizeTitle)
// UILabel can return a size larger than the max size when the number of lines is 1
expectedSizeTitle = CGSize(width:maxSizeTitle.width.getminimum(value2:expectedSizeTitle.width), height: maxSizeTitle.height.getminimum(value2:expectedSizeTitle.height))
lblMessage.frame = CGRect(x:((self.bounds.size.width)/2) - ((expectedSizeTitle.width+16)/2) , y: (self.bounds.size.height/2) - ((expectedSizeTitle.height+16)/2), width: expectedSizeTitle.width+16, height: expectedSizeTitle.height+16)
lblMessage.layer.cornerRadius = 8
lblMessage.layer.masksToBounds = true
lblMessage.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
bgView.addSubview(lblMessage)
self.addSubview(bgView)
lblMessage.alpha = 0

UIView.animateKeyframes(withDuration:TimeInterval(duration) , delay: 0, options: [] , animations: {
lblMessage.alpha = 1
}, completion: {
sucess in
UIView.animate(withDuration:TimeInterval(duration), delay: 8, options: [] , animations: {
lblMessage.alpha = 0
bgView.alpha = 0
})
bgView.removeFromSuperview()
})
}
}
extension CGFloat
{
func getminimum(value2:CGFloat)->CGFloat
{
if self < value2
{
return self
}
else
{
return value2
}
}
}

//MARK: Extension on UILabel for adding insets - for adding padding in top, bottom, right, left.

extension UILabel
{
private struct AssociatedKeys {
static var padding = UIEdgeInsets()
}

var padding: UIEdgeInsets? {
get {
return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
}
set {
if let newValue = newValue {
    objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}
}
}

override open func draw(_ rect: CGRect) {
if let insets = padding {
    self.drawText(in: rect.inset(by: insets))
} else {
self.drawText(in: rect)
}
}

override open var intrinsicContentSize: CGSize {
get {
var contentSize = super.intrinsicContentSize
if let insets = padding {
contentSize.height += insets.top + insets.bottom
contentSize.width += insets.left + insets.right
}
return contentSize
}
}
}
