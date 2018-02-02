//
//  Category.swift
//  Todooey
//
//  Created by Andrew Hogue on 2018-02-02.
//  Copyright © 2018 Andrew Hogue. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
