//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/13/23.
//

import UIKit

protocol ReusableCell {
    static var identifire: String { get }
}


class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView! {
        didSet {
//            cellImageView.backgroundColor = .clear
            
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var cellURL: URL?
}

// MARK: - Identifires for reusable Cells

class ImageCollectionViewCellPlaceholder: ReusableCell {}

extension ReusableCell {
    static var identifire: String {
        return String(describing: self)
    }
}

extension ImageCollectionViewCell: ReusableCell {}

