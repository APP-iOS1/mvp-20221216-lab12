//
//  Model.swift
//  PlantsAndPets
//
//  Created by 전근섭 on 2022/12/13.
//

import Foundation

struct MyUser: Codable, Identifiable {
    var id: String
    var nickName: String
    var email: String
    var name: String
    var profileImageUrl: String
}

struct Post : Codable, Identifiable {
    var id: String
    var currentUser : String
    var bodyText : String
    var postImageUrl : String
    //Date 타입 변환 필요
    var date : String
    //해당 post의 연결되는 comments의 key값
    //var comment : Array<String>
}

struct Comment: Codable, Identifiable {
    var id: String
    var currentUser: String
    var commentText: String
    var date: String
}
