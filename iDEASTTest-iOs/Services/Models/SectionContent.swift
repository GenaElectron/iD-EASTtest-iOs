//
//  SectionContent.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SectionContent: JSONable {
    var id: String?
    var type: String?
    var sectionId: String?
    var sectionName: String?
    var webPublicationDate: Date?
    var webTitle: String?
    var webUrl: URL?
    var apiUrl: URL?
    var isHosted: Bool?
    var pillarId: String?
    var pillarName: String?
    
    init(json: JSON) {
        self.id = json["id"].string
        self.type = json["type"].string
        self.sectionId = json["sectionId"].string
        self.sectionName = json["sectionName"].string
        self.webPublicationDate = convertToDate(from: json["webPublicationDate"].string)
        self.webTitle = json["webTitle"].string
        self.webUrl = json["webUrl"].url
        self.apiUrl = json["apiUrl"].url
        self.isHosted = json["isHosted"].bool
        self.pillarId = json["pillarId"].string
        self.pillarName = json["pillarName"].string
    }
}

extension SectionContent {
    private func convertToDate(from: String?) -> Date?{
        guard let string = from else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: string)
    }
}
