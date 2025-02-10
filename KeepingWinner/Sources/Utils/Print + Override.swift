//
//  Print + Override.swift
//  Yanolja
//
//  Created by 박혜운 on 10/13/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

/// RELEASE 모드에서 프린트 되지 않게 print()에 대한 오버라이딩
func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
#if DEBUG
  Swift.print(items, separator: separator, terminator: terminator)
#endif
}

/// RELEASE 모드에서 프린트 되지 않게 debugPrint()에 대한 오버라이딩
func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
#if DEBUG
  Swift.debugPrint(items, separator: separator, terminator: terminator)
#endif
}
