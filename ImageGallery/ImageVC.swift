//
//  ImageVC.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 1/23/23.
//

import UIKit

class ImageVC: UIViewController {
    
    var galleryImage = UIImageView()
    
    var image: UIImage? {
        get {
            return galleryImage.image
        }
        set {
//            let xOrigin = scrollView.frame.width -
//            let yOrigin =
            galleryImage.image = newValue
            galleryImage.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: scrollView.frame.width , height: scrollView.frame.height))
            scrollView.backgroundColor = .brown
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(galleryImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image = galleryImage.image
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
//            scrollView.addSubview(galleryImage)
        }
    }
}
