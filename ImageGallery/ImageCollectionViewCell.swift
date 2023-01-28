//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/13/23.
//

import UIKit

struct CellComponents {
    
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

    var imageUrl: URL? { didSet { setImage() } }
    
    var backgroundImageOfCell: UIImage? { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        backgroundImageOfCell?.draw(in: bounds)
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
        
        DispatchQueue.global(qos: .userInitiated).async
        {
            let urlContent = try? Data(contentsOf: url.imageURL)
            DispatchQueue.main.async { [weak self] in
                guard let imageData = urlContent else {
                    return
                }
                if self?.imageUrl == url {
                    self?.cellImageView.image = UIImage(data: imageData)
                    self?.spinner.isHidden = true
                    self?.spinner.stopAnimating()
                }
            }
        }
    }
}

