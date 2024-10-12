//
//  ProviderError.swift
//  Core
//
//  Created by 박혜운 on 2023/09/15.
//

import Foundation

public struct ProviderError: Error {
  public var code: Code
  public var userInfo: [String: Any]?
  public var errorBody: ResponseDTO.ErrorData?
  
  public enum Code: Int {
    case failedRequest // 인터넷 불안정
    case isNotSuccessful // 통신 결과 실패
    case failedDecode // 프론트 잘못
    case authenticationFailed
  }
  
  public init(
    code: ProviderError.Code,
    userInfo: [String: Any]? = nil,
    task: (data: Data?, response: URLResponse?)? = nil
  ) {
    self.code = code
    self.userInfo = userInfo
    self.userInfo?["response"] = task?.response
    
    if let data = task?.data {
      do {
        self.errorBody = try JSONDecoder().decode(ResponseDTO.ErrorData.self, from: data)
      } catch {
        dump(error)
      }
    }
  }
}

public extension Error {
  func toProviderError() -> ProviderError? {
    if let error = self as? ProviderError {
      return error
    }
    return nil
  }
}
