//
//  ResponseDTO.swift
//  Core
//
//  Created by 박혜운 on 2023/09/15.
//

import Foundation

public enum ResponseDTO {
  public struct ExistData<ResponseType: Decodable> {
    public let isSuccess: Bool
    public let code: String
    public let message: String
    public let result: ResponseType?
    
    enum CodingKeys: String, CodingKey {
      case isSuccess
      case code
      case message
      case result
    }
  }
  
  public struct ErrorData: Decodable {
    public let isSuccess: Bool
    public let code: String
    public let message: String
  }
}

extension ResponseDTO.ExistData: Decodable where ResponseType: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    isSuccess = try container.decode(Bool.self, forKey: .isSuccess)
    code = try container.decode(String.self, forKey: .code)
    message = try container.decode(String.self, forKey: .message)
    result = try container.decodeIfPresent(ResponseType.self, forKey: .result)
  }
}
