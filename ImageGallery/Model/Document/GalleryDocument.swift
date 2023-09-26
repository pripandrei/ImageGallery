//
//  DocumentImage.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 9/26/23.
//

import Foundation

class GalleryDocument: Codable
{
    static var identifire = 0
    
    var ID: Int
    var title: String?
    var documentComponents = [CellComponents()]
    
    private static func generateUniqueId() -> Int  {
        identifire += 1
        return identifire
    }

    init(title: String) {
        self.title = title
        self.ID = GalleryDocument.generateUniqueId()
    }
    
    convenience init() {
        self.init(title: "")
    }
}
