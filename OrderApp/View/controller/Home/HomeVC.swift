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
    
    var myImageUrlArray = [String]()
    var myTitleArray = [String]()
    var myPriceArray = [String]()
    var myUseremailArray = [String]()
    var myDescArray = [String]()
    var myCategoryArray = [String]()
    var myDocumentId = [String]()
    
    var str1 = "https://imgrosetta.mynet.com.tr/file/1524517/728xauto.jpg"
    var str2 = "https://www.eskelemlak.com/wp-content/uploads/2020/05/bursa-eskel-satilik-bahceli-mustakil-ev-811x510.jpg"
    var str3 = "https://www.ikincielesya.web.tr/wp-content/uploads/2012/10/20170302_123153.jpg"

    override func viewDidLoad() {
        super.viewDidLoad()
        callCollection()
        myAdvertValue()
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
//        myListSlide = [
//            MyListSlide(imageUrl: myImageUrl[0]),
//            MyListSlide(imageUrl: myImageUrl[1]),
//            MyListSlide(imageUrl: myImageUrl[2])
//        ]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func profileButtonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile") as? ProfileVC
        vc?.count = myImageUrlArray.count
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
        if collectionView == myListCollectionView {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "advert") as? AdvertVC
            vc?.userAdvert = true
            vc?.rowCount = myImageUrlArray.count
            vc?.filtDocumentIdArray = myDocumentId
            vc?.filtTitleArray = myTitleArray
            vc?.filtPriceArray = myPriceArray
            vc?.filtImageArray = myImageUrlArray
            vc?.filtDescArray = myDescArray
            vc?.filtCategoryArray = myCategoryArray
            vc?.filtUsernameArray = myUseremailArray
            self.navigationController?.pushViewController(vc!, animated: true)
        }else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "advert") as? AdvertVC
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

extension HomeVC {
    
    func callCollection() {
        advertCollectionView.delegate = self
        myListCollectionView.delegate = self
        advertCollectionView.dataSource = self
        myListCollectionView.dataSource = self
    }
    
    @objc func addNoti() {
        DuplicateFuncs.alertMessage(title: "Başarılı", message: "Ürün Ekleme Başarılı", vc: self)
    }
    
    @objc func deleteNoti() {
        DuplicateFuncs.alertMessage(title: "Başarılı", message: "Ürün Silme Başarılı", vc: self)
    }
    
}

extension HomeVC {
    //MARK: -FİREBASE
    func myAdvertValue(){
        let firebaseDatabase = Firestore.firestore()
        firebaseDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                DuplicateFuncs.alertMessage(title: "Error", message: error?.localizedDescription ?? "", vc: self)
            }else {
                if snapshot?.isEmpty == false {
                    self.myImageUrlArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        if let email = document.get("usernameEmail") as? String {
                            if Auth.auth().currentUser?.email != ""{
                                if Auth.auth().currentUser!.email == email {
                                    if let documentID = document.documentID as? String{
                                        self.myDocumentId.append(documentID)
                                    }
                                    if let email = document.get("usernameEmail") as? String {
                                        self.myUseremailArray.append(email)
                                    }
                                    if let imageUrl = document.get("imageUrl") as? String {
                                        self.myImageUrlArray.append(imageUrl)
                                    }
                                    if let title = document.get("title") as? String {
                                        self.myTitleArray.append(title)
                                    }
                                    if let price = document.get("price") as? String {
                                        self.myPriceArray.append(price)
                                    }
                                    if let category = document.get("category") as? String {
                                        self.myCategoryArray.append(category)
                                    }
                                    if let description = document.get("desc") as? String {
                                        self.myDescArray.append(description)
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
