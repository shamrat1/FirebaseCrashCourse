//
//  CompareFaceViewController.swift
//  FirebaseCrashCourse
//
//  Created by Mac on 3/4/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import SFaceCompare
import Kingfisher

class CompareFaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var compareButton: UIButton!
    var selectedImage = UIImage()
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        // Do any additional setup after loading the view.
        compareButton.isHidden = true
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        selectedImage = image
        dismiss(animated: true, completion: nil)
        compareButton.isHidden = false
    }
    @IBAction func onClickCompare(_ sender: Any) {
        activityIndicator.startAnimating()
        for data in originalData{

            DispatchQueue.global(qos: .default).async {
                let imageURL = URL(string: data.image!)!
                KingfisherManager.shared.retrieveImage(with: imageURL, options: nil, progressBlock: nil, completionHandler: { result in
                    switch result{
                    case .success(let value):
                        print("image: \(value.image) cache: \(value.cacheType)")
                        let compare = SFaceCompare(on: self.selectedImage, and: value.image)
                        compare.compareFaces(succes: { results in
                            
                            print("mached")
                        }, failure: {  error in
                            print("not found")
                        })
                    case .failure(let error):
                        print(error)
                    }
                    
                })
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            }
            
            

        }
        
//        print(originalData)
        
    }
    
    @IBAction func onClickAddImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imageView.image = nil
    }

}
