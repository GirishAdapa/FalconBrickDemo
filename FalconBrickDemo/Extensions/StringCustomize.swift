//
//  StringCustomize.swift
//  FalconBrickDemo
//
//  Created by Abhishek Singh on 07/03/21.
//  Copyright © 2021 Girish. All rights reserved.
//

import UIKit

extension String {
    func SizeOf_String( font: UIFont) -> CGSize {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute)  // for Single Line
       return size;
   }
}
