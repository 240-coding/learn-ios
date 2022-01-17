//
//  UserInformation.swift
//  SignUpProject
//
//  Created by 이서영 on 2022/01/17.
//
import Foundation

class UserInformation {
    static let shared: UserInformation = UserInformation()
    
    var id: String?
    var password: String?
    var phone: String?
    var birth: String? = "Label"
}
