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
    
    @IBOutlet weak var cellImageView: UIImageView!  {
        didSet {
            let asd = Int()
//            cellBackgroundImg = cellImageView.image
        }
    }
//
//
//    var cellImageView: UIImageView = {
////        didSet {
//            let cellImageViewTemp = UIImageView()
//        cellImageViewTemp.image = UIImage(named: "picTest7")
//        cellImageViewTemp.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
////            contentView.addSubview(cellImageView)
////            cellImageView.contentMode = .scaleAspectFit
////            print("image",cellImageView.image?.size)
//            return cellImageViewTemp
////        }
//    }()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var cellBackgroundImg: UIImage?
    
    var cellURL: URL?
//    {
//        didSet {
//            contentView.addSubview(cellImageView)
//            cellImageView.contentMode = .scaleAspectFit
//            print("image",cellImageView.image?.size)
//        }
//    }
    
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

// MARK: - Identifires for reusable Cells

class ImageCollectionViewCellPlaceholder: ReusableCell {}

extension ReusableCell {
    static var identifire: String {
        return String(describing: self)
    }
}

extension ImageCollectionViewCell: ReusableCell {}

