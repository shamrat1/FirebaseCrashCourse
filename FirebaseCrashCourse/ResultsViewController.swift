//
//  ResultsViewController.swift
//  FirebaseCrashCourse
//
//  Created by Mac on 3/21/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Kingfisher

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var matchedResults: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if matchedResults?.count == 0 {
            let alert = UIAlertController(title: "Oh! Snap", message: "No Matched Found", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchedResults!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell") as! ResultsTableViewCell
        cell.nameLabel.text = matchedResults![indexPath.row].name
        cell.numberLabel.text = matchedResults![indexPath.row].phone
        cell.cellImageView.kf.setImage(with: URL(string: matchedResults![indexPath.row].image!))
        cell.addressLabel.text = matchedResults![indexPath.row].address
        cell.statusLabel.text = matchedResults![indexPath.row].status! ? "Found" : "Missing"
        return cell
    }

}
