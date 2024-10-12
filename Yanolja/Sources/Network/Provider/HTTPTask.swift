//
//  HTTPTask.swift
//  Core
//
//  Created by 박혜운 on 2023/09/14.
//

import Foundation
import UIKit

public enum HTTPTask {
  /// 추가 데이터 없는 요청.
  case requestPlain
  /// `Encodable` 타입으로 설정된 요청 바디.
  case requestJSONEncodable(Encodable)
  /// 사용자 정의 인코더와 함께 `Encodable` 타입으로 설정된 요청 바디.
  case requestCustomJSONEncodable(Encodable, encoder: JSONEncoder)
  /// GET의 쿼리 문자열 또는 POST의 바디에 값을 넣을 때 사용.
  case requestParameters(parameters: [String: Any], encoding: EncodingType)
  /// URL 파라미터와 함께 조합된 인코딩된 파라미터로 설정된 요청 바디.
  case requestCompositeParameters(urlParameters: [String: Any], bodyParameters: [String: Any])
  /// Multipart 요청 시.
  case requestMultipartData(parameters: [String: Any], images: [UIImage])
}
