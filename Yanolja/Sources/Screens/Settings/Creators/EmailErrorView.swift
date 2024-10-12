//
//  EmailErrorView.swift
//  Practice_Setting
//
//  Created by 이연정 on 10/8/24.
//

import SwiftUI

struct EmailErrorView: View {
  var body: some View {
    VStack {
      Text("승리지쿄의 더 나은 서비스를 위해\n 이메일로 피드백을 보내주세요.")
        .font(.headline)
        .multilineTextAlignment(.center)
      Text("go9danju@gmail.com")
        .font(.subheadline)
        .padding()
    }
    .padding(.bottom, 300)
    .navigationTitle("오류")
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  EmailErrorView()
}
