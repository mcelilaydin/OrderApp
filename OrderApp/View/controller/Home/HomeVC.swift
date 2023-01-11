//
//  HomeVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 3.01.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage

class HomeVC: BaseVC {
    
    @IBOutlet weak var advertCollectionView: UICollectionView!
    @IBOutlet weak var myListCollectionView: UICollectionView!
    
    var advertSlide: [AdvertSlide] = []
    var myListSlide: [MyListSlide] = []
    var myImageUrl: [String] = []
    
    //MARK: to be fixed !!
    var str1 = "https://firebasestorage.googleapis.com:443/v0/b/orderapp-dcb5d.appspot.com/o/media%2F88588CAE-5AC7-47A6-BFBB-B814D6F31E36.jpg?alt=media&token=08a1f2c1-9b0d-43e3-b17a-7529e8c7d7b7"
    var str2 = "https://firebasestorage.googleapis.com:443/v0/b/orderapp-dcb5d.appspot.com/o/media%2F098BABF5-61AF-415C-AF4B-A0E6DAF1C6A0.jpg?alt=media&token=4938fb55-5a48-4e19-b5cf-47a1641f16a1"
    var str3 = "https://firebasestorage.googleapis.com:443/v0/b/orderapp-dcb5d.appspot.com/o/media%2F94C9A58B-ABB5-437E-92DB-B43DCF23A9D8.jpg?alt=media&token=ef5248ef-fa94-4dcf-9886-344933932f4c"

    override func viewDidLoad() {
        super.viewDidLoad()
        callCollection()
        getImage()
        advertSlide = [
            AdvertSlide(image:UIImage(named: "car")!),
            AdvertSlide(image:UIImage(named: "computer")!),
            AdvertSlide(image:UIImage(named: "phone")!)
        ]
        //MARK: to be fixed !!
        myListSlide = [
            MyListSlide(imageUrl: str1),
            MyListSlide(imageUrl: str2),
            MyListSlide(imageUrl: str3)
        ]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func profileButtonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile") as? ProfileVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.advertCollectionView {
            return advertSlide.count
        }
        return myListSlide.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == advertCollectionView {
            let cellAdvert = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertCollectionViewCell.identifier, for: indexPath) as! AdvertCollectionViewCell
            cellAdvert.setup(advertSlide[indexPath.row])
            return cellAdvert
        }else {
            let cellMyList = collectionView.dequeueReusableCell(withReuseIdentifier: MyListCollectionViewCell.identifier, for: indexPath) as! MyListCollectionViewCell
            cellMyList.setup(myListSlide[indexPath.row])
            return cellMyList
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "advert") as? AdvertVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension HomeVC {
    
    func callCollection(){
        advertCollectionView.delegate = self
        myListCollectionView.delegate = self
        
        advertCollectionView.dataSource = self
        myListCollectionView.dataSource = self
    }
    
}

extension HomeVC {
    //MARK: -FİREBASE
    func getImage(){
        let firebaseDatabase = Firestore.firestore()
        firebaseDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                DuplicateFuncs.alertMessage(title: "Error", message: error?.localizedDescription ?? "", vc: self)
            }else {
                if snapshot?.isEmpty == false {
                    self.myImageUrl.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        if let email = document.get("usernameEmail") as? String {
                            if Auth.auth().currentUser?.email != ""{
                                if Auth.auth().currentUser!.email == email {
                                    if let imageUrl = document.get("imageUrl") as? String {
                                        self.myImageUrl.append(imageUrl)
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
