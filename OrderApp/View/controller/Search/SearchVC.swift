//
//  SearchVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 3.01.2023.
//

import UIKit

class SearchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func uploadButtonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "upload") as? UploadVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
