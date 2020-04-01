//
//  OnboardingViewController.swift
//  onboarding
//
//  Created by Mac on 2/6/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, OnboardingPageViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextButton: UIButton!{
        didSet{
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var skipButton: UIButton!
    
    var pageController : OnboardingPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func didUpdateIndex(currentIndex: Int) {
        
        updateUI()
    }
    @IBAction func nextPage(_ sender: UIButton) {
        if let index = pageController?.currentIndex{
            print("Next clicked for \(index)")
            switch index{
            case 0...1:
                pageController?.forwardPage()
            case 2:
                self.initiateMainStroyboard()
            default:break
            }
        }
        updateUI()
    }
    
    @IBAction func skip(_ sender: UIButton) {
        self.initiateMainStroyboard()
    }
    func updateUI(){
        if let index = pageController?.currentIndex{
            switch index{
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle("Start", for: .normal)
                skipButton.isHidden = true
            default:break
            }
            pageControl.currentPage = index
        }
    }
    
    func initiateMainStroyboard(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "homeViewController") as? HomeViewController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

}
