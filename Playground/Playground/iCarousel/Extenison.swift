//
//  Extenison.swift
//  Playground
//
//  Created by Tnk. on 7/12/2562 BE.
//  Copyright © 2562 Tnk. All rights reserved.
//

import Foundation

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

struct Utility {
    static func loadJsonFrom<T: Codable>(filename: String, for type: T.Type) -> T? {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONDecoder().decode(type, from: data)
                return result
            } catch let error {
                print(error)
                return nil
            }
        }
        return nil
    }
}
