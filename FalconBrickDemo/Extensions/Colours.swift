//
//  Colours.swift
//  FalconBrickDemo
//
//  Created by Abhishek Singh on 07/03/21.
//  Copyright © 2021 Girish. All rights reserved.
//

import UIKit


extension UIColor {
    public convenience init?(hex: String, alpha: CGFloat) {
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor =  String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    let b = CGFloat(hexNumber & 0x0000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: alpha)
                    return
                }
            }
        }
        return nil
    }
}
