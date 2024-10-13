//
//  NicknameChangeView.swift
//  Yanolja
//
//  Created by 박혜운 on 10/13/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct NicknameChangeView: View {
  @Environment(\.dismiss) var dismiss
  @Bindable var userInfoUseCase: UserInfoUseCase
  @State var selectedUserNickname: String = ""
  var noNicknameUser: Bool = false
  
  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 0) {
        if !noNicknameUser {
          Button(action: {
            dismiss()
          }) {
            Text("취소")
          }
        } else {
          Text("취소")
            .foregroundStyle(.clear)
        }
        Spacer()
        Text("닉네임 변경")
          .bold()
        Spacer()
        Button(action: {
          userInfoUseCase.effect(.changeMyNickname(selectedUserNickname))
          dismiss()
        }) {
          Text("완료")
            .bold()
        }
        .disabled(selectedUserNickname.isEmpty)
      }
      .frame(height: 44)
      .padding(.top, 16)
      .padding(.bottom, 20)
      
      
      if let myNickname = userInfoUseCase.state.myNickname {
        // 지정한 닉네임이 있다면 사용하던 닉네임이 보인다
        NicknameSettingsContent(inputText: $selectedUserNickname)
          .onAppear {
            selectedUserNickname = myNickname
          }
          .presentationDragIndicator(.visible)
      } else {
        // 지정한 닉네임이 없으면 그대로 실행
        NicknameSettingsContent(inputText: $selectedUserNickname)
          .presentationDragIndicator(.visible)
      }
      Spacer()
    }
    .padding(.horizontal, 16)
  }
}
