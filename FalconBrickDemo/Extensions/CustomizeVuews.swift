//
//  CustomizeVuews.swift
//  FalconBrickDemo
//
//  Created by Abhishek Singh on 07/03/21.
//  Copyright © 2021 Girish. All rights reserved.
//

import UIKit

extension UISearchBar{
    func searchBarCustomize(colour: UIColor){

        if let textfield = self.value(forKey: "searchField") as? UITextField {
            self.backgroundImage = UIImage()
            textfield.backgroundColor = colour
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            textfield.placeholder = "Enter search terms here"
            textfield.textColor = .white
            if let leftView = textfield.leftView as? UIImageView {
                
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor(hex: "#F7CC55", alpha: 1.0)!
            }

        }
    }

}
