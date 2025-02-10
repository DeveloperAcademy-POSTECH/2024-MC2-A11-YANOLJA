//
//  MockData.swift
//  Core
//
//  Created by 박혜운 on 2023/09/17.
//

import Foundation

public protocol MockDataProtocol: JsonDataToDataProtocol {
  var data: Data { get }
  func data(fileName: String, extension: String) -> Data!
}

public protocol JsonDataToDataProtocol {
  func data(fileName: String, extension: String) -> Data!
}

public extension JsonDataToDataProtocol {
  func data(fileName: String, extension: String) -> Data! {
    let fileLocation = Bundle.main.url(
      forResource: fileName,
      withExtension: `extension`
    )!
    return try? Data(contentsOf: fileLocation)
  }
}
