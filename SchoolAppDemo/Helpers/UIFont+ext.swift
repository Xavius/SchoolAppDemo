//
//  UIFont+ext.swift
//  SchoolAppDemo
//
//  Created by Михаил Шикин on 29.12.2022.
//

import UIKit

extension UIFont {
    enum FontWeight {
        case black
        case blackItalic
        case bold
        case boldItalic
        case extraLight
        case extraLightItalic
        case italic
        case light
        case lightItalic
        case regular
        case semiBold
        case semiBoldItalic
    }
    static func sourceSansPro(with weight: FontWeight, and size: CGFloat) -> UIFont {
        var fontWeightName: String
        switch weight {
            case .black:
                fontWeightName = "Black"
            case .blackItalic:
                fontWeightName = "BlackItalic"
            case .boldItalic:
                fontWeightName = "BoldItalic"
            case .extraLight:
                fontWeightName = "ExtraLight"
            case .extraLightItalic:
                fontWeightName = "ExtraLightItalic"
            case .italic:
                fontWeightName = "Italic"
            case .light:
                fontWeightName = "Light"
            case .lightItalic:
                fontWeightName = "LightItalic"
            case .semiBold:
                fontWeightName = "SemiBold"
            case .semiBoldItalic:
                fontWeightName = "SemiBoldItalic"
            default:
                fontWeightName = "Regular"
        }
        let font = UIFont(name: "SourceSansPro-\(fontWeightName)", size: size)
        return font ?? UIFont()
    }

    static func bebasNeue(with size: CGFloat) -> UIFont {
        let font = UIFont(name: "BebasNeue-Regular", size: size)
        return font ?? UIFont()
    }
}
