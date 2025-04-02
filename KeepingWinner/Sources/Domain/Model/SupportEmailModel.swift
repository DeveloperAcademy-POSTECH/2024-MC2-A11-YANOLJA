//
//  SupportEmailModel.swift
//  Practice_Setting
//
//  Created by 이연정 on 10/8/24.
//

import SwiftUI

struct SupportEmailModel {
  var toAddress: String
  var subject: String
  var body: String = "더 나은 서비스를 위해 피드백을 보내주세요"
  
  /// 이메일 보내기 함수
  func send(openURL: OpenURLAction) {
    let emailString = "mailto:\(toAddress)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "")"
    if let emailURL = URL(string: emailString) {
      openURL(emailURL)
    }
  }
}
