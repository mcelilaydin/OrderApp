//
//  SignUpVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 2.01.2023.
//

import UIKit
import FirebaseAuth

class SignUpVC: BaseVC {
    
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldAtt()
        setButtonAtt()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if UsernameTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: UsernameTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil {
                    DuplicateFuncs.alertMessage(title: "Firebase Error", message: error?.localizedDescription ?? "Error", vc: self)
                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as? LoginVC
                    vc?.toSignUp = true
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
        } else {
            DuplicateFuncs.alertMessage(title: "Hata", message: "Kullanıcı Adı/Şifre Doldurunuz", vc: self)
        }
        
    }

}

extension SignUpVC {
        
        func setTextFieldAtt(){
            UsernameTextField.attributeTextField(Str: "Kullanıcı Adı")
            UsernameTextField.leftPadding(10)
            passwordTextField.leftPadding(10)
            passwordTextField.attributeTextField(Str: "Şifre")
            UsernameTextField.autocorrectionType = .no
            passwordTextField.autocorrectionType = .no
        }
        
        func setButtonAtt() {
            signUpBtn.backgroundColor = .gray
        }
        
}
