//
//  URLSessionProtocol.swift
//  Core
//
//  Created by 박혜운 on 2023/09/16.
//

import Foundation

public protocol URLSessionProtocol {
  func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
