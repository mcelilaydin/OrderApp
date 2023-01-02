//
//  LoginVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 2.01.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    var toSignUp: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldAtt()
        setButtonAtt()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        toVCSignUp()
    }
    
    @IBAction func loginButonClicked(_ sender: Any) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil {
                    DuplicateFuncs.alertMessage(title: "Error", message: error?.localizedDescription ?? "Firebase Error", vc: self)
                }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as? UITabBarController
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
        } else{
            DuplicateFuncs.alertMessage(title: "Hata", message: "Kullanıcı Adı/Şifre Doldurunuz", vc: self)
        }
    }
    
    @IBAction func signUpButonClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "signup") as? SignUpVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}


extension LoginVC {
    
    func setTextFieldAtt(){
        usernameTextField.attributeTextField(Str: "Kullanıcı Adı")
        usernameTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        usernameTextField.leftPadding(10)
        passwordTextField.leftPadding(10)
        passwordTextField.attributeTextField(Str: "Şifre")
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textFieldEyeButton(eyeImage: "eye.png")
    }
    
    func setButtonAtt() {
        loginBtn.backgroundColor = .gray
        signupBtn.backgroundColor = .gray
        signupBtn.setTitleColor(.white, for: .normal)
    }
    
    func toVCSignUp(){
        if toSignUp == true {
            DuplicateFuncs.alertMessage(title: "Başarılı", message: "Kayıt işlemi Başarılı", vc: self)
        }
    }
}
