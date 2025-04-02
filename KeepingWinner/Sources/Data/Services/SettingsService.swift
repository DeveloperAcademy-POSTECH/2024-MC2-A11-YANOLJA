//
//  SettingsService.swift
//  Yanolja
//
//  Created by 박혜운 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

extension SettingsService {
  static let live = {
    return Self(
      characterBubbleTexts: { myTeam in
        let result = await Provider<GameRecordInfoAPI>
          .init()
          .request(
            SettingsAPI.characterBubbleTexts(myTeam: myTeam),
            type: TeamLineDTO.self
          )
        switch result {
        case let .success(teamLineDto): return .success(teamLineDto.line)
        case let .failure(error): return .failure(error)
        }
      },  allStadiums: {
        let result = await Provider<GameRecordInfoAPI>
          .init()
          .request(
            SettingsAPI.allStadiums,
            type: StadiumsDTO.self
          )
        switch result {
        case let .success(stadiumsDTO): return .success(stadiumsDTO.stadiums)
        case let .failure(error): return .failure(error)
        }
      }, allNotices: {
        let result = await Provider<SettingsAPI>
          .init()
          .request(
            SettingsAPI.allNotices,
            type: NoticesDTO.self
          )
        
        switch result {
        case let .success(noticesDTO):
          let notices = noticesDTO.notices
          let newNotices: [NoticeModel] = notices.map { NoticeModel(date: $0.date, title: $0.noticeName, contents: $0.noticeComment) }
          return .success(newNotices)
        case let .failure(error): return .failure(error)
        }
      }
    )
  }()
  
  static let preview = {
    return Self(
      characterBubbleTexts: { _ in
        let result = ["오늘은 누구 응원할까?", "내가 혹시 승리요정??", "어느 구단으로 취직하지?", "이기는 팀 우리 팀?", "홈런 가자!?"]
        return .success(result)
      },  allStadiums: {
        let result = ["잠실종합운동장야구장", "인천SSG랜더스필드", "울산문수야구장", "대구삼성라이온즈파크", "창원NC파크", "부산사직야구장", "광주KIA챔피언스필드", "고척스카이돔", "포항야구장", "대전한화생명이글스파크", "수원KT위즈파크"]
        return .success(result)
      }, allNotices: {
        let result = [NoticeModel(
          date: "",
          title: "🍁더위가 가고 가을 야구가 찾아왔어요! 1.0 업데이트 안내",
          contents: "깔끔하고 단순한 화면은 물론, 더 편하고 확실하게 나의 직관 승률을 확인해봐요!"
        )]
        return .success(result)
      }
    )
  }()
}
