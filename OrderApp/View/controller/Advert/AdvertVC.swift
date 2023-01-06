//
//  CategoryVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 5.01.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage

class AdvertVC: UIViewController {

    @IBOutlet weak var advertTableView: UITableView!
    
    var useremailArray = [String]()
    var titleArray = [String]()
    var priceArray = [String]()
    var categoryArray = [String]()
    var imageUrlArray = [String]()
    var descArray = [String]()
    //var dateArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advertTableView.delegate = self
        advertTableView.dataSource = self
        getData()
        advertTableView.register(UINib.init(nibName: AdvertCell.identifier, bundle: nil), forCellReuseIdentifier: AdvertCell.identifier)
        
        // Do any additional setup after loading the view.
    }

}

extension AdvertVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useremailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = advertTableView.dequeueReusableCell(withIdentifier: AdvertCell.identifier,for: indexPath) as! AdvertCell
        cell.advertİmageView.sd_setImage(with: URL(string: imageUrlArray[indexPath.row]))
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.priceLabel.text = priceArray[indexPath.row]
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "upload") as! UploadVC
//        vc.modalPresentationStyle = .fullScreen
//       // vc.categoryText = categoryArray[indexPath.row]
//        self.present(vc, animated: true, completion: nil)
//    }
}

extension AdvertVC {
    
    func getData(){
        
        let firebaseDatabase = Firestore.firestore()
        
        firebaseDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                DuplicateFuncs.alertMessage(title: "Error", message: error?.localizedDescription ?? "", vc: self)
            }else {
                if snapshot?.isEmpty == false {
                    self.useremailArray.removeAll(keepingCapacity: false)
                    self.titleArray.removeAll(keepingCapacity: false)
                    self.priceArray.removeAll(keepingCapacity: false)
                    self.categoryArray.removeAll(keepingCapacity: false)
                    self.imageUrlArray.removeAll(keepingCapacity: false)
                    self.descArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentId = document.documentID
                        
                        if let email = document.get("usernameEmail") as? String {
                            self.useremailArray.append(email)
                        }
                        if let title = document.get("title") as? String{
                            self.titleArray.append(title)
                        }
                        if let price = document.get("price") as? String {
                            self.priceArray.append(price)
                        }
                        if let category = document.get("category") as? String {
                            self.categoryArray.append(category)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.imageUrlArray.append(imageUrl)
                        }
                        if let description = document.get("desc") as? String {
                            self.descArray.append(description)
                        }
                    }
                    self.advertTableView.reloadData()
                }
            }
        }
    }
    
}
