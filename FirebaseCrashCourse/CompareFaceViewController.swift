//
//  CompareFaceViewController.swift
//  FirebaseCrashCourse
//
//  Created by Mac on 3/4/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class CompareFaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var compareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        // Do any additional setup after loading the view.
        compareButton.isHidden = true
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
        compareButton.isHidden = false
    }
    @IBAction func onClickCompare(_ sender: Any) {
        print(originalData)
    }
    
    @IBAction func onClickAddImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imageView.image = nil
    }

}
