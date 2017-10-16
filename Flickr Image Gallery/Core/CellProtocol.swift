//
//  CellProtocol.swift
//  Flickr Image Gallery
//
//  Created by Enrique Melgarejo on 15/10/17.
//  Copyright © 2017 Choynowski. All rights reserved.
//

import UIKit

protocol CellProtocol: class {
    static var identifier: String { get }
}

extension CellProtocol where Self: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension CellProtocol where Self: UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol SetupCellProtocol: CellProtocol {
    associatedtype T

    func setup(with model: T?)
}
