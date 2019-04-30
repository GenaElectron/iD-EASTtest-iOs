//
//  Extention+Date.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 28.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

extension Date {
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
