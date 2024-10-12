//
//  Provider.swift
//  Core
//
//  Created by 박혜운 on 2023/09/15.
//

import Foundation

fileprivate var isRefreshingTokenFail: Bool = false

public struct Provider<Target: EndPointType> {
  private let session: URLSessionProtocol
  private let responseLogger = NetworkLogger()
  
  public init(
    session: URLSessionProtocol = Session.shared.session
  ) {
    self.session = session
  }
  
  public func request<T: Decodable>(
    _ endPoint: EndPointType,
    type: T.Type
  ) async -> Result<T, Error> {
    return await requestObject(endPoint, type: type)
  }
}

// MARK: Private Request Methods
private extension Provider {
  func requestObject<T: Decodable>(_ endPoint: EndPointType, type: T.Type) async -> Result<T, Error> {
    
    guard let request = endPoint.asURLRequest() else {
      let error = ProviderError(
        code: .failedDecode,
        userInfo: ["endPoint" : endPoint]
      )
      return .failure(error)
    }
    
    let task = try? await session.data(for: request)
    
    guard let (data, response) = task else {
      let error = ProviderError(
        code: .failedRequest,
        userInfo: ["endPoint" : endPoint]
      )
      return .failure(error)
    }
    
    responseLogger.logResponse(response: response, data: data)
    
    guard let httpResponse = response as? HTTPURLResponse,
    200..<300 ~= httpResponse.statusCode else {
      let error = ProviderError(
        code: .isNotSuccessful,
        userInfo: ["endPoint" : endPoint],
        task: (data, response)
      )
      return .failure(error)
    }
    
    let targetModel = try? JSONDecoder().decode(ResponseDTO.ExistData<T>.self, from: data)
    
    guard let targetModel = targetModel, let model = targetModel.result else {
      let error = ProviderError(
        code: .failedDecode,
        userInfo: ["endPoint" : endPoint],
        task: (data, response)
      )
      return .failure(error)
    }
    
    return .success(model)
  }
}
