//
//  Protocols.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import SwiftyJSON

protocol JSONable {
    init(json: JSON)
}

protocol NibLoadable: class {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: name, bundle: Bundle.init(for: self))
    }
    static var name: String {
        return String(describing: self)
    }
}

extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError()
        }
        return view
    }
}
