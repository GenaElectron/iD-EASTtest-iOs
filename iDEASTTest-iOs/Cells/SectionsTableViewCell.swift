//
//  SectionsTableViewCell.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import CollectionAndTableViewCompatible

class SectionsTableViewCell: UITableViewCell, Configurable, NibLoadable {
    
    @IBOutlet weak var webTitleLabel: UILabel!
    @IBOutlet weak var webUrlLabel: UILabel!
    
    var model: SectionsCellModel?
    
    func configure(withModel model: SectionsCellModel) {
        self.model = model
        webTitleLabel.text = model.webTitle
        webUrlLabel.text = model.webUrl
        selectionStyle = model.selected ? .default : .none
    }
}
