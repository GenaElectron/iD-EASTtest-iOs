//
//  SectionsCellModel.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import CollectionAndTableViewCompatible

class SectionsCellModel: TableViewCompatible{
    
    var reuseIdentifier: String {
        return SectionsTableViewCell.name
    }
    
    let webTitle: String
    let webUrl: String
    let rawData: Section
    
    var selected: Bool = true
    
    init(section: Section) {
        self.rawData = section
        self.webTitle = section.webTitle ?? ""
        self.webUrl = section.webUrl?.absoluteString ?? ""
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SectionsTableViewCell
        cell.configure(withModel: self)
        return cell
    }
}
