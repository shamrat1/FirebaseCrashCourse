//
//  HomeViewController.swift
//  FirebaseCrashCourse
//
//  Created by Mac on 3/3/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

var originalData = [Person]()

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let dbRef = Database.database().reference()
    var data = [Person]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadData()
    }
    func loadData(){
        dbRef.observe(.value) { (snapshot) in

            self.data = []
            for personObject in snapshot.children.allObjects as! [DataSnapshot] {
                let person = personObject.value as? [String:Any]
                //                print(person)
                
                let dataToAppend = Person(id: (person?["id"] as! String), name: person?["name"] as? String, age: person?["age"] as? String, phone: person?["phone"] as? String, address: person?["address"] as? String, image: person?["image"] as? String, status: person?["status"] as? Bool)
                self.data.append(dataToAppend)
                
            }
            self.tableView.reloadData()
            originalData = self.data
//            print(self.data)
        }
    }

    @IBAction func onClickFilter(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            data.removeAll()
            data = originalData
            print("Total persons: \(data.count)")
            self.tableView.reloadData()
        case 1:
            data.removeAll()
            for person in originalData{
                if let status = person.status {
                    if !status {
                        data.append(person)
                    }
                }
            }
            print("missing: \(self.data.count)")
            self.tableView.reloadData()
        case 2:
            data.removeAll()
            for person in originalData{
                if let status = person.status {
                    if status {
                        data.append(person)
                    }
                }
            }
            print("found: \(self.data.count)")
            self.tableView.reloadData()
        default:
            return
        }
    }
}

extension HomeViewController :UITableViewDataSource, UITableViewDelegate{
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    print("data count \(data?.count)")
        return data.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as! HomeTableViewCell
            let imageURL = data[indexPath.row].image
            cell.cellView.layer.borderWidth = 1
            cell.cellView.layer.borderColor = data[indexPath.row].status! ? UIColor.green.cgColor : UIColor.red.cgColor
            cell.cellView.layer.cornerRadius = 10
            cell.personImageView.kf.setImage(with: URL(string: imageURL!))
            cell.nameLabel.text = data[indexPath.row].name
            cell.addressLabel.text = data[indexPath.row].address
            cell.ageLabel.text = data[indexPath.row].age
            return cell
        }
}

