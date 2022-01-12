//
//  UserInfomation.swift
//  ViewTransition
//
//  Created by 이서영 on 2022/01/11.
//

import Foundation

class UserInformation {
    static let shared: UserInformation = UserInformation() // 타입 프로퍼티 (static이라서 공유 가능)
    
    var name: String?
    var age: String?
}
