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
