//
//  ProfileVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 2.01.2023.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }catch{
            print("Logout başarısız")
        }
    }
}
