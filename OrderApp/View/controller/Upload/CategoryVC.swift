//
//  CategoryVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 5.01.2023.
//

import UIKit

class CategoryVC: UIViewController {

    @IBOutlet weak var categoryTableView: UITableView!
    
    var categoryArray: [String] = ["buzdolabı","masa","televizyon","kaşık","çatal","bardak","sandalye","koltuk"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

}

extension CategoryVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = categoryArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "upload") as! UploadVC
        vc.modalPresentationStyle = .fullScreen
        vc.categoryText = categoryArray[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
