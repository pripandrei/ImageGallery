//
//  DocumentTableCell.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/31/23.
//

import UIKit

class DocumentTableCell: UITableViewCell {

    var id: Int?
    var title: String?
    var components = [CellComponents()]
    
    var imageGalleryDocumentTableVC: ImageGalleryDocumentTableVC? {
        didSet {
            if imageGalleryDTVCWasSet == false {
                imageGalleryDTVCWasSet = true
            }
        }
    }
    
    var imageGalleryDTVCWasSet: Bool = false {
        didSet {
            addCellGestureRecognizers(self)
        }
    }

    func addCellGestureRecognizers(_ cell: UITableViewCell) {
        let singleTap = UITapGestureRecognizer(target: imageGalleryDocumentTableVC, action: #selector(imageGalleryDocumentTableVC?.handleSingleCellTap))
        singleTap.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: imageGalleryDocumentTableVC, action: #selector(imageGalleryDocumentTableVC?.handleDoubleCellTap))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
        
        singleTap.require(toFail: doubleTap)
    }
}
