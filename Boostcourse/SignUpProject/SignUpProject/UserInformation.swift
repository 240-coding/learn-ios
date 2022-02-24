//
//  UserInformation.swift
//  SignUpProject
//
//  Created by 이서영 on 2022/01/17.
//
import Foundation
import UIKit

class UserInformation {
    static let shared: UserInformation = UserInformation()
    
    var id: String?
    var password: String?
    var introduce: String?
    var image: UIImage!
    var phone: String?
    var birth: String? = "Label"
}
