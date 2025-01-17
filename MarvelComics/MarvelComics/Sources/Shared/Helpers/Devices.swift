//
//  Devices.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 17/1/25.
//

import UIKit

enum Devices: CaseIterable {
    case iPhoneSE
    case iPhone8
    case iPhone11
    case iPhone13ProMax

    var size: CGSize {
        switch self {
        case .iPhoneSE:
            return CGSize(width: 320, height: 568)
        case .iPhone8:
            return CGSize(width: 375, height: 667)
        case .iPhone11:
            return CGSize(width: 414, height: 896)
        case .iPhone13ProMax:
            return CGSize(width: 428, height: 926)
        }
    }

    var name: String {
        switch self {
        case .iPhoneSE:
            return "iPhone SE"
        case .iPhone8:
            return "iPhone 8"
        case .iPhone11:
            return "iPhone 11"
        case .iPhone13ProMax:
            return "iPhone 13 Pro Max"
        }
    }
}
