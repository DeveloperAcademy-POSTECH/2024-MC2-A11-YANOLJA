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
      ZStack {
        Image("Creators")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: UIScreen.main.bounds.width)
          .background(Color.brandColor)
      }
      
      List {
        Section(header: Text("팀 승리지쿄")) {
          NavigationLink(destination: EmptyView()) {
            HStack {
              Text("인스타그램")
              Spacer()
              Text("@keeping_winner")
                .foregroundStyle(.secondary)
            }
          }
          .simultaneousGesture(TapGesture().onEnded {
            openInstagram()
          })
          
          NavigationLink(destination: EmptyView()) {
            HStack {
              Text("이메일")
              Spacer()
              Text("go9danju"+"@gmail.com")
                .foregroundStyle(.secondary)
            }
          }
          .simultaneousGesture(TapGesture().onEnded {
            if MFMailComposeViewController.canSendMail() {
              email.send(openURL: openURL)
            } else {
              showEmailView = true
            }
          })
        }
      }
      .scrollDisabled(true)
      .tint(.black)
    }
  }
  
  func openInstagram() {
    let appURL = URL(string: "instagram://user?username=keeping_winner")!
    let webURL = URL(string: "https://instagram.com/keeping_winner")!
    
    if UIApplication.shared.canOpenURL(appURL) {
      openURL(appURL)
    } else {
      openURL(webURL)
    }
  }
}

#Preview {
  CreatorsView()
}
