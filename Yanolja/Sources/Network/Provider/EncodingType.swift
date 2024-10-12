//
//  EncodingType.swift
//  Core
//
//  Created by 박혜운 on 2023/09/14.
//

import Foundation
import UIKit

public enum EncodingType {
  case jsonBody
  case queryString
  case multiPart
}

extension EncodingType {
  func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?, images: [UIImage]?) throws -> URLRequest {
    var urlRequest = urlRequest
    switch self {
    case .jsonBody:
      if let parameters = parameters {
        let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        urlRequest.httpBody = jsonData
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      }
      
    case .queryString:
      // 쿼리 문자열로 인코딩
      if let parameters = parameters {
        let queryString = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        if var urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false) {
          urlComponents.query = queryString
          urlRequest.url = urlComponents.url
        }
      }
      
    case .multiPart:
      if let parameters = parameters {
        let boundary = generateBoundaryString()
        
        let body = try createMultipartBody(
          parameters: parameters,
          boundary: boundary,
          images: images
        )
        
        urlRequest.setValue(
          "multipart/form-data; boundary=\(boundary)",
          forHTTPHeaderField: "Content-Type"
        )
        urlRequest.httpBody = body
      }
    }
    return urlRequest
  }
}


fileprivate extension EncodingType {
  private func createMultipartBody(
    parameters: [String: Any],
    boundary: String,
    images: [UIImage]?
  ) throws -> Data {
    var body = Data()

    body.append("--\(boundary)\r\n")
    body.append("Content-Disposition: form-data; name=\"request\"\r\n")
    body.append("Content-Type: application/json\r\n\r\n")
    
    let jsonData = try JSONSerialization.data(
      withJSONObject: parameters,
      options: []
    )
    
    body.append(jsonData)
    body.append("\r\n")
    
    if let images = images {
      for image in images {
        if let imageData = image.jpegData(compressionQuality: 0.7) {
          body.append(
            convertFileData(
              fieldName: "multipartFiles",
              fileName: "\(Date.now)_photo.jpg",
              mimeType: "image/jpeg",
              fileData: imageData,
              using: boundary
            )
          )
        }
      }
    }
    
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    
    return body
  }
  
  private func convertFileData(
    fieldName: String,
    fileName: String,
    mimeType: String,
    fileData: Data,
    using boundary: String) -> Data {

    var data = Data()
    
    data.append("--\(boundary)\r\n")
    data.append("Content-Disposition: form-data; name=\"\(fieldName)\";  filename=\"\(fileName)\"\r\n")
    data.append("Content-Type: \(mimeType)\r\n\r\n")
    data.append(fileData)
    data.append("\r\n")
    
    return data
  }
  
  private func generateBoundaryString() -> String {
    return UUID().uuidString
  }
}

fileprivate extension Data {
  mutating func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
