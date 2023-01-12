//
//  ProfileVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 2.01.2023.
//

import UIKit
import Firebase

class ProfileVC: BaseVC {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var advertCount: UILabel!
    @IBOutlet weak var changePassword: UITextField!
    @IBOutlet weak var changePasswordTwo: UITextField!
    
    var count: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changePasswordClicked(_ sender: Any) {
        if changePassword.text != "" {
            if changePassword.text == changePasswordTwo.text {
                Auth.auth().currentUser?.updatePassword(to: changePasswordTwo.text!,completion: { error in
                    if error != nil {
                        DuplicateFuncs.alertMessage(title: "Error", message: error?.localizedDescription ?? "Error", vc: self)
                    }else {
                        self.changePassword.text = ""
                        self.changePasswordTwo.text = ""
                        DuplicateFuncs.alertMessage(title: "Başarılı", message: "Şifre değiştirme başarılı.", vc: self)
                    }
                })
            }else {
                DuplicateFuncs.alertMessage(title: "Hata", message: "Lütfen Aynı şifre Giriniz", vc: self)
            }
        }
    }

    @IBAction func logoutButtonClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }catch{
            DuplicateFuncs.alertMessage(title: "Hata", message: "Çıkış Başarısız", vc: self)
        }
    }
}

extension ProfileVC {
    
    func setLabel() {
        if Auth.auth().currentUser != nil {
            usernameLabel.text = Auth.auth().currentUser!.email
        }
        advertCount.text = "\(count)"
        profileImageView.image = UIImage(named: "Foto")
    }
    
}
