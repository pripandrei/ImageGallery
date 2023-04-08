//
//  TextFieldTableViewCell.swift
//  ImageGallery
//
//  Created by Andrei Pripa on 4/9/23.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {


    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
            textField.bounds = self.contentView.bounds
        }
    }
    
    
}
