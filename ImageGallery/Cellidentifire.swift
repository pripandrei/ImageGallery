//
//  Cellidentifire.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/27/23.
//

import Foundation

protocol ReusableCell {
    static var identifire: String { get }
}

// MARK: - Identifires for reusable Cells

class ImageCollectionViewCellPlaceholder: ReusableCell {}

extension ReusableCell {
    static var identifire: String {
        return String(describing: self)
    }
}

extension ImageCollectionViewCell: ReusableCell {}

extension DocumentTableCell: ReusableCell {}
