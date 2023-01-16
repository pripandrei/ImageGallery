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

    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }


}
