//
//  Theme.swift
//  PhotoSharing
//
//  Created by Chris Mays on 2/20/17.
//  Copyright © 2017 WillowTree. All rights reserved.
//

import Foundation
import UIKit

public class Theme
{
    // MARK: Colors
    public static func backgroundGray() -> UIColor
    {
        return UIColor.init(colorLiteralRed: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 255.0/255.0)
    }

    public static func titleBlack() -> UIColor
    {
        return UIColor.init(colorLiteralRed: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.8)
    }

    public static func descriptionBlack() -> UIColor
    {
        return UIColor.init(colorLiteralRed: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.6)
    }

    public static func buttonBackgroundBlue() -> UIColor
    {
        return UIColor.init(colorLiteralRed: 15.0/255.0, green: 79.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    }

    public static func socialBlue() -> UIColor
    {
        return UIColor.init(colorLiteralRed: 9.0/255.0, green: 78.0/255.0, blue: 117.0/255.0, alpha: 1.0)
    }

    // MARK: Fonts

    public static func regularWithSize(size: CGFloat) -> UIFont
    {
        return UIFont(name: "OpenSans", size: size)!
    }

    public static func lightWithSize(size: CGFloat) -> UIFont
    {
        return UIFont(name: "OpenSans-Light", size: size)!
    }

    public static func semiBoldWithSize(size: CGFloat) -> UIFont
    {
        return UIFont(name: "OpenSans-Semibold", size: size)!
    }

    // MARK: AttributeString helpers
    public static func attributedString(text : String, font : UIFont, textColor: UIColor, letterSpacing: CGFloat) -> NSMutableAttributedString
    {
        let attributedString = NSMutableAttributedString(string: text)

        let stringRange = NSRange(location: 0, length: text.characters.count);
        attributedString.addAttribute(NSFontAttributeName, value: font, range: stringRange)
        attributedString.addAttribute(NSKernAttributeName, value: letterSpacing, range: stringRange)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: textColor, range: stringRange)

        return attributedString
    }


}
