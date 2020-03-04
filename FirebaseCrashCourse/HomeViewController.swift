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

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let dbRef = Database.database().reference()
    var data = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dbRef.observe(.value) { (snapshot) in
//            debugPrint(snapshot)
//            if let data = snapshot.value {
//                self.data = data as? [String : Any]
//                print(self.data)
//            }
            self.data = []
            for personObject in snapshot.children.allObjects as! [DataSnapshot] {
                let person = personObject.value as? [String:Any]
                print(person)
                
                let dataToAppend = Person(id: (person?["id"] as! String), name: person?["name"] as? String, age: person?["age"] as? String, phone: person?["phone"] as? String, address: person?["address"] as? String, image: person?["image"] as? String, status: person?["status"] as? Bool)
                self.data.append(dataToAppend)
                
            }
            self.tableView.reloadData()
            print(self.data)
        }
    }
    

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    print("data count \(data?.count)")
    return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as! HomeTableViewCell
        let imageURL = data[indexPath.row].image
        cell.personImageView.kf.setImage(with: URL(string: imageURL!))
        cell.nameLabel.text = data[indexPath.row].name
        cell.addressLabel.text = data[indexPath.row].address
        cell.ageLabel.text = data[indexPath.row].age
        return cell
    }
    

}
