//
//  HomeVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 3.01.2023.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func profileButtonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "profile") as? ProfileVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
