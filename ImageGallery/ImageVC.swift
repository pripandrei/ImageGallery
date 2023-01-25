//
//  ImageVC.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/23/23.
//

import UIKit

class ImageVC: UIViewController {
    
    var galleryImage = UIImageView()
    
    var tempIMG = UIImage()
//
    var image: UIImage? {
        get {
            return galleryImage.image
        }
        set {
            galleryImage.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: scrollView.frame.width / 2, height: scrollView.frame.height / 2))
            galleryImage.image = newValue
            scrollView.backgroundColor = .brown
            scrollView.contentSize = CGSize(width: scrollView.frame.width * 2, height: scrollView.frame.height * 2)
            scrollView.addSubview(galleryImage)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        image = tempIMG
//        galleryImage.image = tempIMG
        image = galleryImage.image
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
//            scrollView.addSubview(galleryImage)
        }
    }
}
