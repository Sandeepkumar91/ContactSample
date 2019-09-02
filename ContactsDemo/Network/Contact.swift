//
//  Contact.swift
//  ContactsDemo
//
//  Created by Apple on 02/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import Foundation

class Contact : Decodable {
    var id: Int?
    var first_name: String?
    var last_name: String?
    var favorite: Bool?
    var profile_pic: String?
    var phone_number: String?
    var email: String?
}
