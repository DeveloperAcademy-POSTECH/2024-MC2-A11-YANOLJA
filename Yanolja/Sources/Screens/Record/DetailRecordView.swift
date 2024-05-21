//
//  DetailRecordView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

enum RecordViewEditType {
  case create
  case edit
}

// MARK: - 고스트 꺼
struct DetailRecordView: View {
  let editType: RecordViewEditType
  
  
  @State private var date = Date()
  @State var selectedGame = ""
  @State var selectedMyTeam = ""
  @State var selectedYourTeam = ""
  @State var selectedStadium = "잠실"
  var gameResults = ["승리", "패배", "무승부"]
  var allTeams = ["두산 베어스", "롯데 자이언츠", "삼성 라이온즈", "키움 히어로즈" ,"한화 이글스", "LG 트윈스", "NC 다이노스", "SSG 랜더스", "KIA 타이거즈", "KT 위즈"]
  var stadiums = ["고척스카이돔","광주기아챔피언스필드", "대구삼성라이온즈파크", "대전한화생명이글스파크","사직야구장", "수원KT위즈파크", "인천SSG랜더스필드" ,"잠실야구장", "창원NC파크", "포항야구장"]
  
  
  init(to editType: RecordViewEditType) {
    self.editType = editType
  }
  
  var body: some View {
    List() {
      Section(
        "직관 정보",
        content: {
          // DatePicker 사용
          selectDate
          // 나의 팀, 상대팀 Picker
          HStack(spacing: 10) {
            SelectTeamView(
              type: .my,
              selectedTeam: .doosan,
              tappedAction: { selectedTeam in
                print("\(selectedTeam)되잖아")
              }
            )
            
            Text("VS")
              .font(.title2)
              .foregroundStyle(.gray)
            
            SelectTeamView(
              type: .vs,
              selectedTeam: .doosan,
              tappedAction: { selectedTeam in
                print("\(selectedTeam)되잖아")
                
              }
            )
          }
          // 경기장 Picker
          Picker("경기장", selection: $selectedStadium) {
            ForEach(stadiums, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.menu)
        }
      )
      // 직관 결과 선택 picker
      Picker("직관 결과", selection: $selectedGame){
        ForEach(gameResults, id: \.self) {
          Text($0)
        }
      }
      .pickerStyle(.inline)
      
      
      if editType == .edit {
        Button(
          action: {
            print("고스트 바보")
          },
          label: {
            Text("삭제")
          }
        )
      }
    }
  }
  
  var selectDate: some View {
    DatePicker(
      "날짜",
      selection: $date,
      displayedComponents: [.date]
    )
  }
}

#Preview {
  DetailRecordView(to: .edit)
}
