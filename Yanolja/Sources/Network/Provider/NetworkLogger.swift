//
//  NetworkEventLogger.swift
//  Core
//
//  Created by 박혜운 on 2023/09/15.
//

import Foundation

final class NetworkLogger: NSObject {
  var receivedData: Data? = nil
  
  func logRequest(_ request: URLRequest) {
    debugPrint("⚾️ Network Request Log ⚾️")
    debugPrint("  📮 [URL] : \(request.url?.absoluteString ?? "")")
    debugPrint("  📮 [Method] : \(request.httpMethod ?? "")")
    debugPrint("  📮 [Headers] : \(request.allHTTPHeaderFields ?? [:])")
    
    
    if let body = request.httpBody?.toPrettyPrintedString {
      debugPrint("  📮 [Body]: \(body)")
    } else {
      debugPrint("  📮 [Body]: Body가 없습니다.")
    }
    debugPrint("=====================================")
  }
  
  // 응답 로깅
  func logResponse(response: URLResponse?, data: Data?) {
    debugPrint("⚾️ Network Response Log ⚾️")
    if let response = response as? HTTPURLResponse {
      debugPrint("  📩 [Status Code] : \(response.statusCode)")
      if let data = data, let responseString = data.toPrettyPrintedString {
        debugPrint("  📩 [Response] : \(responseString)")
      }
      
      switch response.statusCode {
      case 400..<500:
        debugPrint("  📩 클라이언트 오류")
      case 500..<600:
        debugPrint("  📩 서버 오류")
      default:
        break
      }
    }
    debugPrint("=====================================")
  }
}

extension NetworkLogger: URLSessionTaskDelegate {
  func urlSession(_ session: URLSession, didCreateTask task: URLSessionTask) {
    if let request = task.originalRequest {
      logRequest(request)
    }
  }
  
  func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
     logResponse(response: task.response, data: receivedData)
    receivedData = nil
  }
  
  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
     logResponse(response: task.response, data: receivedData)
    receivedData = nil
  }
}

extension NetworkLogger: URLSessionDataDelegate {
  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    if receivedData == nil {
      receivedData = Data()
    }
    receivedData?.append(data)
  }
}

fileprivate extension Data {
  var toPrettyPrintedString: String? {
    guard let object = try? JSONSerialization.jsonObject(
      with: self, options: []
    ),
    let data = try? JSONSerialization.data(
      withJSONObject: object,
      options: [.prettyPrinted]
    ),
    let prettyPrintedString = NSString(
      data: data,
      encoding: String.Encoding.utf8.rawValue
    ) else {
      return nil
    }
    return prettyPrintedString as String
  }
}

/// RELEASE 모드에서 프린트 되지 않게 print()에 대한 오버라이딩
fileprivate func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
#if DEBUG
  Swift.print(items, separator: separator, terminator: terminator)
#endif
}

/// RELEASE 모드에서 프린트 되지 않게 debugPrint()에 대한 오버라이딩
fileprivate func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
#if DEBUG
  Swift.debugPrint(items, separator: separator, terminator: terminator)
#endif
}
