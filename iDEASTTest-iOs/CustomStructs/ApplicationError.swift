//
//  ApplicationError.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 29.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//
import Foundation

struct ApplicationError: Error {
    let description : String
    var localizedDesc: String {
        return NSLocalizedString(description, comment: "")
    }
}
