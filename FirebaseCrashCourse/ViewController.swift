//
//  ViewController.swift
//  FirebaseCrashCourse
//
//  Created by Mac on 3/1/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let dbRef = Database.database().reference()
//        dbRef.childByAutoId().setValue([
//            "name":"Yasin Shamrat",
//            "email":"yshamrat@gmail.com",
//            "age":24
//        ])
        dbRef.child("-M1Ojlvj4F_cUTS3Dvpu").observe(.value, with: { (snap) in
            print(snap.value!)
        })
        dbRef.observe(.value) { (snapshot) in
            print(snapshot.value!)
        }
    }


}

