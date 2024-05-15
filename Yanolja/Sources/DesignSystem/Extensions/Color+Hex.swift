//
//  Color+Hex.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

extension Color {
  init(hexString: String, opacity: Double = 1) {
    let scanner = Scanner(string: hexString)
    _ = scanner.scanString("#")
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let red = Double((rgb & 0xFF0000) >> 16) / 255
    let green = Double((rgb & 0x00FF00) >> 8) / 255
    let blue = Double(rgb & 0x0000FF) / 255
    
    self.init(red: red, green: green, blue: blue, opacity: opacity)
  }
  
  init(hex: Int, opacity: Double = 1.0) {
    let red = Double((hex >> 16) & 0xff) / 255
    let green = Double((hex >> 8) & 0xff) / 255
    let blue = Double((hex >> 0) & 0xff) / 255
    
    self.init(red: red, green: green, blue: blue, opacity: opacity)
  }
}
