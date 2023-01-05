//
//  UploadVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 3.01.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var priceTextfield: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var okeyBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func okeyButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    DuplicateFuncs.alertMessage(title: "Error", message: error?.localizedDescription ?? "Error", vc: self)
                }else{
                    
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString

                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference: DocumentReference? = nil
                            
                            let firestorePosts = [
                                "imageUrl" : imageUrl!,
                                "usernameEmail" : Auth.auth().currentUser!.email,
                                "title" : self.titleTextfield.text!,
                                "category" : self.categoryTextfield.text!,
                                "price" : self.priceTextfield.text!,
                                "desc" : self.descTextView.text!,
                                "date": FieldValue.serverTimestamp()
                            ] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePosts,completion: { error in
                                if error != nil {
                                    DuplicateFuncs.alertMessage(title: "Error", message: error?.localizedDescription ?? "", vc: self)
                                } else {
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true, completion: nil)
                                }
                            })
                            
                        }
                    }
                    
                }
            }
        
        }
    }

}

extension UploadVC {
    
    func setImageView(){
        uploadImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        uploadImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage(){
        
        let picketController = UIImagePickerController()
        picketController.delegate = self
        picketController.sourceType = .photoLibrary
        present(picketController, animated: true,completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    
}
