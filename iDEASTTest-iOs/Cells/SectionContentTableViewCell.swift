//
//  SectionContentTableViewCell.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 28.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import CollectionAndTableViewCompatible

class SectionContentTableViewCell: UITableViewCell, Configurable, NibLoadable {
    
    @IBOutlet weak var sectionTypeLabel: UILabel!
    @IBOutlet weak var webPublicationDateLabel: UILabel!
    @IBOutlet weak var webTitleLabel: UILabel!
    @IBOutlet weak var webUrlLabel: UILabel!
    
    var model: SectionContentCellModel?
    
    func configure(withModel model: SectionContentCellModel) {
        self.model = model
        sectionTypeLabel.text = model.type
        webPublicationDateLabel.text = model.webPublicationDate
        webTitleLabel.text = model.webTitle
        webUrlLabel.text = model.webUrl
        selectionStyle = model.selected ? .default : .none
    }
}
