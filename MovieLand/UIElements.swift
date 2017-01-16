//
//  UIElements.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/11/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import Foundation

import UIKit

extension UIFont {
    
    class func brown(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Brown-Regular", size: size)!
    }
    
    class func brownBold(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Brown-Bold", size: size)!
    }
    
    class func brownLight(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Brown-Light", size: size)!
    }
    
    class func brownLightItalic(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "Brown-LightItalic", size: size)!
    }
}

extension UILabel {
    
    class func labelWithUnderline() -> UILabel {
        return UILabel()
    }
}

extension UIImage {
    
    func grayscaleImage() -> UIImage {
        // reference: http://stackoverflow.com/questions/1298867/convert-image-to-grayscale  jan 15 answer
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let imageRect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(self.size.width), height: CGFloat(self.size.height))
        let ctx = UIGraphicsGetCurrentContext()
        // Draw a white background
        ctx?.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ctx?.fill(imageRect)
        // Draw the luminosity on top of the white background to get grayscale
        self.draw(in: imageRect, blendMode: .luminosity, alpha: 1.0)
        // Apply the source image's alpha
        self.draw(in: imageRect, blendMode: .destinationIn, alpha: 1.0)
        let grayscaleImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return grayscaleImage!
    }
}
