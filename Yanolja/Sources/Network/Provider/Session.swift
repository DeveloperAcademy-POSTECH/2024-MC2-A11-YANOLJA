//
//  Session.swift
//  Core
//
//  Created by 박혜운 on 2023/09/15.
//

import Foundation

public final class Session {
  public static let shared = Session()
  
  public let session: URLSession
  
  private init() {
    let configuration = URLSessionConfiguration.default
    let logger = NetworkLogger()
    session = URLSession(
      configuration: configuration,
      delegate: logger,
      delegateQueue: nil
    )
  }
}
