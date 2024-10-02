//
//  NicknameSettingsView.swift
//  Yanolja
//
//  Created by 박혜운 on 9/29/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct NicknameSettingsContentView: View {
  @Binding var inputText: String
  
  var body: some View {
    TextField("닉네임을 입력해 주세요", text: $inputText)
      .font(.headline)
      .overlay(
        alignment: .trailing,
        content: {
          Text("\(inputText.count) / 10")
            .font(.callout)
            .foregroundStyle(Color(uiColor: .systemGray2))
        }
      )
      .padding(.horizontal, 16)
      .padding(.vertical, 20)
      .background(
        RoundedRectangle(cornerRadius: 12)
          .fill(Color(uiColor: .systemGray6))
      )
      .onChange(of: inputText) { oldValue, newValue in
        if newValue.count > 10 {
          inputText = String(newValue.prefix(10))
        }
      }
  }
}

#Preview {
  NicknameSettingsContentView(inputText: .constant(""))
}
