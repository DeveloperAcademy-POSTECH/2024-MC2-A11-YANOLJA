//
//  EndPointType.swift
//  Core
//
//  Created by 박혜운 on 2023/09/14.
//

import Foundation

public protocol EndPointType {
  var baseURL: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var task: HTTPTask { get }
}

public extension EndPointType {
  /// Default is `["Content-Type": "application/json"]`
  var headers: [String: String] {
    return ["Content-Type": "application/json"]
  }
}

public extension EndPointType {
  
  func asURLRequest() -> URLRequest? {
    var urlComponents = URLComponents(string: self.baseURL)
    urlComponents?.path += self.path
    
    guard let url = urlComponents?.url else {
      return nil
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = self.method.rawValue
    
    self.headers.forEach { key, value in
      urlRequest
        .setValue(
          value,
          forHTTPHeaderField: key
        )
    }
    
    return try? addParameter(to: urlRequest)
  }
  
  
  private func addParameter(to request: URLRequest) throws -> URLRequest {
    var request = request
    
    switch task {
    case .requestPlain:
      break
      
    case let .requestJSONEncodable(parameters):
      request.httpBody = try JSONEncoder().encode(parameters)
      
    case let .requestCustomJSONEncodable(parameters, encoder):
      request.httpBody = try encoder.encode(parameters)
      
    case let .requestParameters(parameters, encoding):
      request = try encoding.encode(request, with: parameters, images: [])
      
    case let .requestCompositeParameters(query, body):
      request = try EncodingType.queryString.encode(request, with: query, images: [])
      request = try EncodingType.jsonBody.encode(request, with: body, images: [])
      
    case let .requestMultipartData(parameters, images):
      request = try EncodingType.multiPart.encode(request, with: parameters, images: images)
    }
    
    return request
  }
}
