//
//  ContentView.swift
//  Practice_Setting
//
//  Created by 이연정 on 10/8/24.
//

import MessageUI
import SwiftUI

struct CreatorsView: View {
  
  @Environment(\.openURL) var openURL
  private var email = SupportEmailModel(toAddress: "go9danju@gmail.com", subject: "팀 승리지쿄에게 문의하기")
  @State private var showEmailView: Bool = false
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack{
        Image("Creators")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: UIScreen.main.bounds.width)
          .background(Color.brandColor)
      }
      
      List {
        Section(header: Text("팀 승리지쿄")) {
          Button(action: {
            openInstagram()
          }) {
            HStack {
              Text("인스타그램")
              Spacer()
              Text("@keeping_winner")
                .foregroundStyle(.secondary)
              Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
            }
            
          }
          
          Button(action: {
            if MFMailComposeViewController.canSendMail() {
              email.send(openURL: openURL)
            } else {
              showEmailView = true
            }
          }) {
            HStack {
              Text("이메일")
              Spacer()
              Text("go9danju"+"@gmail.com")
                .foregroundStyle(.secondary)
              Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
            }
          }
        }
      }
      .foregroundStyle(.primary)
    }
  }
  
  func openInstagram() {
    let appURL = URL(string: "instagram://user?username=keeping_winner")! // 인스타그램 앱 URL
    let webURL = URL(string: "https://instagram.com/keeping_winner")! // 웹 브라우저용 URL
    
    if UIApplication.shared.canOpenURL(appURL) {
      // 인스타그램 앱이 설치되어 있으면 앱으로 이동
      openURL(appURL)
    } else {
      // 설치되어 있지 않으면 웹 브라우저로 이동
      openURL(webURL)
    }
  }
}

#Preview {
  CreatorsView()
}
