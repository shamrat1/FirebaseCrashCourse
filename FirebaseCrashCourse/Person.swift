//
//  Person.swift
//  FirebaseCrashCourse
//
//  Created by Mac on 3/3/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation


class Person {
    var id: String?
    var name: String?
    var age: String?
    var phone: String?
    var address: String?
    var image: String?
    var status: Bool?
    
    init(id:String?,name: String?,age: String?,phone: String?,address: String?,image: String?,status: Bool?) {
        self.id = id
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        self.image = image
        self.status = status
    }
}
