//
//  Section.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Section: JSONable {
    var id: String?
    var webTitle: String?
    var webUrl: URL?
    var apiUrl: URL?
    
    init(json: JSON) {
        self.id = json["id"].string
        self.webTitle = json["webTitle"].string
        self.webUrl = json["webUrl"].url
        self.apiUrl = json["apiUrl"].url
    }
}
