//
//  ImageView.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/11/23.
//

import UIKit

class ImageView: UIView {
    
    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }

//    var cellUrl: URL?

    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }


}


struct CellComponent {
    
    var cellURL: URL?
    
    var cellSize: CGSize?

    var cellAspectRatio: CGSize {
        get {
            return cellSize ?? CGSize()
        }
        set {
//            guard let cellWidth = newValue?.width, let cellHeight = newValue?.height else {
//                return
//            }
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
