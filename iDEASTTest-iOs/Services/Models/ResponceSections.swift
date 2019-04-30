//
//  ResponceSections.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 30.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponceSections: JSONable {
    var status: String?
    var userTier: String?
    var total: Int?
    var content: [Section]?
    
    init(json: JSON) {
        if let responce = json["response"].dictionary {
            self.status = responce["status"]?.string
            self.userTier = responce["userTier"]?.string
            self.total = responce["total"]?.int
            self.content = responce["results"]?.array?.map({ Section(json: $0)})
        }
    }
}
