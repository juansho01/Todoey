//
//  item.swift
//  Todoey
//
//  Created by Juan David  Perafan on 6/26/19.
//  Copyright © 2019 Juan David  Perafan. All rights reserved.
//

import Foundation

//class Item: Encodable, Decodable {
//    var title : String = ""
//    var done : Bool = false
//}

class Item: Codable{
    var title : String = ""
    var done : Bool = false
}
