//
//  ImageVC.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/23/23.
//

import UIKit

class ImageVC: UIViewController {
    
    lazy var galleryImage = UIImageView()
    
    var image: UIImage? {
        get {
            return galleryImage.image
        }
        set {
            galleryImage.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: scrollView.frame.width / 2, height: scrollView.frame.height / 2))
            galleryImage.image = newValue
            scrollView.backgroundColor = .brown
            scrollView.contentSize = CGSize(width: scrollView.frame.width * 2, height: scrollView.frame.height * 2)
        }
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        image = galleryImage.image
//    }

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.addSubview(galleryImage)
//            self.image = galleryImage.image
//            let image = UIImage(named: "picTest1")
//            self.image = image
        }
    }
}
