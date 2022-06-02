//
//  ViewController.swift
//  Quizio
//
//  Created by Gideon Bedzrah on 08/08/2020.
//  Copyright © 2020 Gideon Bedzrah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth



class HomeViewController: UIViewController {
   
    let userDefaults = UserDefaults.standard
    let mainCellData = MainCellData()
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let profileIcon = UIButton()
    let storage = Storage.storage()
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

//        let navIcon = UIButton()
//                     navIcon.setImage(UIImage(named: "LogoIcon"), for: .normal)
//                     navIcon.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//                     navIcon.addTarget(self, action: #selector(iconTapped), for: .touchUpInside)
//                     navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navIcon)
        
        
        //Present Pop up alert
        
    }

   
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.profileIcon.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        
        
//        if let imageCache = cacheImage.object(forKey: NSString(string: "userProfilePic")) {
//                    profileIcon.setImage(imageCache, for: .normal)
//               }else {
//            
//            //we download
//            if let user = Auth.auth().currentUser?.uid {
//                storage.reference(withPath: "ProfileImage/\(user).jpeg").getData(maxSize: 4 * 1024 * 1024) { (data, error) in
//                    var downloadedImage: UIImage?
//                    
//                    if let err = error {
//                        print("error downloading data: \(err)")
//                        //if the user hasn't yet set an image we use the default
//                        self.profileIcon.setImage(UIImage(named: "IconProfilee"), for: .normal)
//                        
//                        
//                        
//                    }else {
//                        if let d = data {
//                            downloadedImage = UIImage(data: d)
//                            if downloadedImage != nil {
//                                print("redownloading image")
//                                cacheImage.setObject(downloadedImage!, forKey: NSString(string: "userProfilePic"))
//                                DispatchQueue.main.async {
//                                    self.profileIcon.setImage(downloadedImage!, for: .normal)
//                                    
//                                }
//                            }else {
//                                self.profileIcon.setImage(UIImage(named: "IconProfilee"), for: .normal)
//                            }
//                        }else {
//                            self.profileIcon.setImage(UIImage(named: "IconProfilee"), for: .normal)
//                        }
//                        
//                    }
//                }
//            }
//           
//           
//        }
//
//        profileIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//        profileIcon.layer.cornerRadius = profileIcon.frame.height/2
//        profileIcon.contentMode = .redraw
//        profileIcon.clipsToBounds = true
//        profileIcon.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
//
//
//        let right = UIBarButtonItem(customView: profileIcon)
//        let currWidth = right.customView?.widthAnchor.constraint(equalToConstant: 40)
//        currWidth?.isActive = true
//        let currHeight = right.customView?.heightAnchor.constraint(equalToConstant: 40)
//        currHeight?.isActive = true
//        navigationItem.rightBarButtonItem = right
        
         navigationController?.navigationBar.prefersLargeTitles = true
    }
   
        
         
    @IBAction func profileButtonTapped(_ sender: Any) {
        
    }
    
    
    
    
    @objc func iconTapped() {
//        print("present new view controller")
//        performSegue(withIdentifier: "toAck", sender: self)
    }
    
    
        
    let akanHeading = ["Ghana abakɔsem sɛn na wonim?", "Menntumi nka nti na me drɔm", "Waben wɔ nkontaboɔmu ne sikasem mu?", "Sua Ghana amamrɛ a agye din wɔ omanyimu", "Iphone a edikan ɛba afi bɛn mu?"]
    
    
}

extension HomeViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainCellData.myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        
        if defaults.bool(forKey: "Akan") {
            cell.subHeadingLabel.text = akanHeading[indexPath.row]
        }else {
            cell.subHeadingLabel.text = mainCellData.myArray[indexPath.row].subtitle
        }
        cell.headingLabel.text = mainCellData.myArray[indexPath.row].title
        cell.tileImage.image = UIImage(named: "\(mainCellData.myArray[indexPath.row].image)")
        cell.accentColorView.backgroundColor = mainCellData.myArray[indexPath.row].accent
        
        return cell
        
    }
    
//    func buttonPressed(button, indexPath: IndexPath) {
//        
//    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            let destinationVC = segue.destination as! ExpandViewController
            let indexPath = tableView.indexPathForSelectedRow
            destinationVC.selectedCell = mainCellData.myArray[indexPath!.row]
        }
    }
    
    
}


