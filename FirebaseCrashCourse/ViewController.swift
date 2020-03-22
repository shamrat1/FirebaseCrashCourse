//
//  ViewController.swift
//  FirebaseCrashCourse
//
//  Created by Mac on 3/1/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePickerController = UIImagePickerController()
    var userPickedImage: UIImage?
    let dbRef = Database.database().reference()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        
//        dbRef.childByAutoId().setValue([
//            "name":"Yasin Shamrat",
//            "email":"yshamrat@gmail.com",
//            "age":24
//        ])
//        dbRef.child("-M1Ojlvj4F_cUTS3Dvpu").observe(.value, with: { (snap) in
//            print(snap.childSnapshot(forPath: "name").value!)
//        })
//        dbRef.observe(.value) { (snapshot) in
//            debugPrint(snapshot)
//            for value in snapshot.value! as? [String:Any] ?? [:] {
//                //
//            }
//        }
//        dbRef.observeSingleEvent(of: .value) { (snap) in
//            print(snap.value!)
//        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = selectedImage
            self.userPickedImage = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onClickNavButton(_ sender: Any) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func onClickSaveButton(_ sender: Any) {
       
        if let name = nameField.text, let age = ageField.text, let address = addressField.text, let phone = phoneNumberField.text , let image = userPickedImage {
             print("name: \(name)\nAge: \(age)\nAddress: \(address)\nPhone: \(phone)\nImage: \(image.description)")
            let id = UUID().uuidString
            let storageRef = Storage.storage().reference().child("\(id).jpg")
            
            if let compressedImage = image.jpegData(compressionQuality: 0.7) {
                storageRef.putData(compressedImage, metadata: nil) { (meta, error) in
                    if error != nil {
                        print(error!)
                    }else{
                        storageRef.downloadURL { (url, error) in
                            if let imageUrl = url?.absoluteString {
                                print(imageUrl)
                                self.dbRef.child(id).setValue([
                                    "id":id,
                                    "name": name,
                                    "age": age,
                                    "address": address,
                                    "phone": phone,
                                    "image": imageUrl,
                                    "status" : 0
                                ])
                                
                            }
                        }
                    }
                }
                self.clearFields()
            }
            
            print("here")
        }else {
            let alert = UIAlertController(title: "Warning", message: "Please fillup all fields and pick an image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func clearFields(){
        self.nameField.text = nil
        self.ageField.text = nil
        self.addressField.text = nil
        self.imageView.image = nil
        self.phoneNumberField.text = nil
        
        let alert = UIAlertController(title: "Success", message: "Data saved successfully.", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
}

