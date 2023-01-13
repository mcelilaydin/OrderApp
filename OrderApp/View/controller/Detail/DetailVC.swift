//
//  DetailVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 13.01.2023.
//

import UIKit
import SDWebImage
import Firebase

class DetailVC: UIViewController {
    
    @IBOutlet weak var detailImageVİew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    var detailValue = Detail(documentId: "", username: "", imageUrl: "", title: "", price: "", category: "", desc: "", date: "")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Ürün Detay"
        userControl()
        setView()
        // Do any additional setup after loading the view.
    }
    
}

extension DetailVC {
    
    func setView(){
        detailImageVİew.sd_setImage(with: URL(string: detailValue.imageUrl))
        titleLabel.text = detailValue.title.uppercased()
        priceLabel.text = detailValue.price.currencyInputFormatting()
        categoryLabel.text = detailValue.category.uppercased()
        usernameLabel.text = detailValue.username
        dateLabel.text = detailValue.date
        descTextView.text = detailValue.desc
        
        descTextView.isEditable = false
    }
    
    func userControl(){
        if Auth.auth().currentUser?.email != nil {
            if detailValue.username == Auth.auth().currentUser!.email {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteClicked))
                navigationItem.titleView?.tintColor = .black
            }
        }
    }
    @objc func deleteClicked(){
        let firebaseDatabase = Firestore.firestore()
        firebaseDatabase.collection("Posts").document(detailValue.documentId).delete() { error in
            if error != nil {
                DuplicateFuncs.alertMessage(title: "Error", message: error?.localizedDescription ?? "Error", vc: self)
            }else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
