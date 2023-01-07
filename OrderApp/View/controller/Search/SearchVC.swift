//
//  SearchVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 3.01.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class SearchVC: BaseVC {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    var categoryArray = [String]()
    var uniqueArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        getCategory()

        // Do any additional setup after loading the view.
    }

    @IBAction func uploadButtonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "upload") as? UploadVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniqueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = uniqueArray[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "advert") as? AdvertVC
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
}

extension SearchVC {
    
    //MARK: - FİREBASE
    
    func getCategory() {
        let firebaseDatabase = Firestore.firestore()
        
        firebaseDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                DuplicateFuncs.alertMessage(title: "Error", message: error?.localizedDescription ?? "Error", vc: self)
            }else {
                if snapshot?.isEmpty == false {
                    self.categoryArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        if let category = document.get("category") as? String {
                            self.categoryArray.append(category)
                        }
                    }
                    self.uniArray()
                    self.searchTableView.reloadData()
                }
            }
        }
    }
    
    func uniArray(){
        for i in categoryArray {
            let trimmedString = i.trimmingCharacters(in: .whitespaces).uppercased()
            if !uniqueArray.contains(trimmedString) {
                uniqueArray.append(trimmedString)
            }
        }
    }
    
}
