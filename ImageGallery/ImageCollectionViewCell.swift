//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/13/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var imageUrl: URL? { didSet { setImage() } }
    
    var loader = ImageLoader()

//    override func draw(_ rect: CGRect) {
//        backgroundImageOfCell?.draw(in: bounds)
//    }
}

struct CellComponents: Equatable {
    
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

extension ImageCollectionViewCell
{
    private func setImage() {
        guard let url = imageUrl else {
            return
        }
        self.cellImageView.image = nil
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        
        loader.fetch(url, complitionHandler: { [weak self] image in
            if let image = image {
                if self?.imageUrl == url {
                    self?.cellImageView.image = image
                    self?.spinner.isHidden = true
                    self?.spinner.stopAnimating()
                }
            }
        })
    }
}
