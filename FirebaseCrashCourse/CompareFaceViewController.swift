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
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var matchedRes = [Person]()
    
    let queue = DispatchQueue(label: "download.and.compareFace",  attributes: .concurrent)
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        // Do any additional setup after loading the view.
        compareButton.isHidden = true
        self.compareButton.setTitle("Compare", for: .selected)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
//        activityIndicator.style = .large
        view.addSubview(activityIndicator)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.compareButton.setTitle("Compare", for: .normal)
        compareButton.isHidden = true
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        selectedImage = image
        dismiss(animated: true, completion: nil)
        compareButton.isHidden = false
    }
    @IBAction func onClickCompare(_ sender: Any) {
        self.compareButton.setTitle("Compare...", for: .selected)
        activityIndicator.startAnimating()
//        self.queue.async(group: self.group) {
        for data in originalData{
            self.group.enter()
            
                let imageURL = URL(string: data.image!)!
                KingfisherManager.shared.retrieveImage(with: imageURL, options: nil, progressBlock: nil, completionHandler: { result in
                    switch result{
                    case .success(let value):
                        print("image: \(value.image) cache: \(value.cacheType)")
                        
                            let compare = SFaceCompare(on: self.selectedImage, and: value.image)
                        self.group.enter()
                            compare.compareFaces(succes: { results in
                                self.matchedRes.append(data)
                                print("matched")
                            }, failure: {  error in
                                print("not found")
                            })
                        
                        self.group.leave()
                        
                        
                    case .failure(let error):
                        print(error)
                    }
                    self.group.leave()
                })
                
            
            
            

            }
            
//        }
        group.notify(queue: .main) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "compareToResults", sender: self)
            }
            print(self.matchedRes)
        }
        
//        print(originalData)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "compareToResults" {
            let vc = segue.destination as! ResultsViewController
            vc.matchedResults = [Person]()
            vc.matchedResults = matchedRes
        }
    }
    
    @IBAction func onClickAddImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imageView.image = nil
    }

}
