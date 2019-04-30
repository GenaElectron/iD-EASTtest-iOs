//
//  ResponceSectionContent.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponceSectionContent: JSONable {
    var status: String?
    var userTier: String?
    var total: Int?
    var startIndex: Int?
    var pageSize: Int?
    var currentPage: Int?
    var pages: Int?
    var content: [SectionContent]?
    
    init(json: JSON) {
        if let responce = json["response"].dictionary {
            self.status = responce["status"]?.string
            self.userTier = responce["userTier"]?.string
            self.total = responce["total"]?.int
            self.startIndex = responce["startIndex"]?.int
            self.pageSize = responce["pageSize"]?.int
            self.currentPage = responce["currentPage"]?.int
            self.pages = responce["pages"]?.int
            self.content = responce["results"]?.array?.map({ SectionContent(json: $0)})
        }
    }
}

