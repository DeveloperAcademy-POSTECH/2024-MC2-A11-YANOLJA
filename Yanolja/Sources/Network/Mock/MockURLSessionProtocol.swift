//
//  MockURLSessionProtocol.swift
//  Core
//
//  Created by 박혜운 on 2023/09/16.
//

import Foundation

public final class MockURLSession<MockDataType: MockDataProtocol>: URLSessionProtocol, JsonDataToDataProtocol {

  // MARK: - Properties
  
  let urlSession: URLSession = {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    let urlSession = URLSession(configuration: configuration)
    return urlSession
  }()

  let isFailRequest: Bool
  let mockData: MockDataType?

  let successStatusCode = 200
  let failureStatusCode = 401
  

  // MARK: - Initialization
  
  public init(
    mockData: MockDataType?
  ) {
    self.mockData = mockData
    self.isFailRequest = (mockData == nil)
  }

  // MARK: - Public Methods
  
  public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    let successResponse = HTTPURLResponse(
      url: request.url!,
      statusCode: successStatusCode,
      httpVersion: "2",
      headerFields: nil)!
    
    let failureResponse = HTTPURLResponse(
      url: request.url!,
      statusCode: failureStatusCode,
      httpVersion: "2",
      headerFields: nil)!

    let response = isFailRequest ? failureResponse : successResponse
    
    let data = isFailRequest ? data(fileName: "fail_data", extension: "json") : mockData?.data

    return (data!, response)
  }
}
