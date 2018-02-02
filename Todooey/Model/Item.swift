//
//  Item.swift
//  Todooey
//
//  Created by Andrew Hogue on 2018-02-02.
//  Copyright © 2018 Andrew Hogue. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    //@objc dynamic var dateCreated : Date? = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
