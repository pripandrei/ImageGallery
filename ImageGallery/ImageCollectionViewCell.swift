//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/13/23.
//

import UIKit

struct CellComponents {
    
    var identifire: Int?
    
    var cellURL: URL?
    var cellSize: CGSize?
    
    var cellAspectRatio: CGSize {
        get {
            return cellSize ?? CGSize()
        }
        set {
            let cellWidth = newValue.width
            let cellHeight = newValue.height
            let preferredCellWidth = 300.0
            var preferredCellHeight = CGSize().height
            
            let ratio = round((cellWidth / cellHeight) * 100) / 100
            preferredCellHeight = round((preferredCellWidth / ratio) * 100) / 100
            cellSize = CGSize(width: preferredCellWidth, height: preferredCellHeight)
        }
    }
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var identifire: Int?

    var backgroundImageOfCell: UIImage? { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        backgroundImageOfCell?.draw(in: bounds)
    }
}

