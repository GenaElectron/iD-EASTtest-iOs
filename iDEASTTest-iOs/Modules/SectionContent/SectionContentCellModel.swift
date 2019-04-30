//
//  SectionContentCellModel.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 28.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import CollectionAndTableViewCompatible

class SectionContentCellModel: TableViewCompatible{
    
    var reuseIdentifier: String {
        return SectionContentTableViewCell.name
    }
    
    let type: String
    let webTitle: String
    let webUrl: String
    let webPublicationDate: String
    let rawData: SectionContent
    
    var selected: Bool = false
    
    init(content: SectionContent) {
        self.rawData = content
        self.type = content.type ?? ""
        self.webPublicationDate = content.webPublicationDate?.getDateString() ?? ""
        self.webTitle = content.webTitle ?? ""
        self.webUrl = content.webUrl?.absoluteString ?? ""
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SectionContentTableViewCell
        cell.configure(withModel: self)
        return cell
    }
}
