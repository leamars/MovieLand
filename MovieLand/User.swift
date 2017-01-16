//
//  User.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/16/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

class User {
    let name:String?
    var numberRated: Int = 0
    
    init(with name: String) {
        self.name = name
    }
}
