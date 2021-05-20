//
//  UIScreen+extension.swift
//  NovelBooks
//
//  Created by BigSur on 09/05/2021.
//

import UIKit

extension UIScreen {
    class func screenWidth() -> CGFloat {
        return main.bounds.width
    }
    
    class func screenHeight() -> CGFloat {
        return main.bounds.height
    }
}
