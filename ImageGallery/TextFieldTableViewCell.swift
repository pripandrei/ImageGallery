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
        }
    }
    
    var resignetionHandler: (() -> (Void))?
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        resignetionHandler?()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
