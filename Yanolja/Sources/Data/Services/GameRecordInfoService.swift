//
//  TeamInfoService.swift
//  Yanolja
//
//  Created by 박혜운 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

extension GameRecordInfoService {
  static let live = {
    return Self(
      gameRecord: { date, myTeam in
        let result = await Provider<GameRecordInfoAPI>
          .init()
          .request(
            GameRecordInfoAPI.realRecord(date: date.asYearMonthDayWithDash, myTeam: myTeam),
            type: [BaseballGameDTO].self
          )
        
        switch result {
        case let .success(gameDTO):
          let recordList = gameDTO.map { dto in
            return GameRecordWithScoreModel(
              date: dto.date.toCalendarDate(),
              stadiums: dto.stadium,
              myTeam: baseballTeamConvertFrom(dto.myTeam),
              vsTeam: baseballTeamConvertFrom(dto.vsTeam),
              isDoubleHeader: dto.doubleHeaderGameOrder,
              myTeamScore: dto.myTeamScore,
              vsTeamScore: dto.vsTeamScore,
              isCancel: dto.cancel
            )
          }
          return .success(recordList)
        case let .failure(error): return .failure(error)
        }
      }, teamWinRate: { myTeam in
        let result = await Provider<GameRecordInfoAPI>
          .init()
          .request(
            GameRecordInfoAPI.teamWinRate(myTeam: myTeam),
            type: TeamWinRateDTO.self
          )
        switch result {
        case let .success(winRateDto):
          let winRate: Int = Int(winRateDto.winRate * 100)
          return .success(winRate)
        case let .failure(error): return .failure(error)
        }
      }
    )
  }()
  
  private static func baseballTeamConvertFrom(_ team: String) -> BaseballTeam {
      switch team {
      case "두산": return .doosan
      case "롯데": return .lotte
      case "삼성": return .samsung
      case "한화": return .hanwha
      case "키움": return .kiwoom
      case "KIA": return .kia
      case "KT": return .kt
      case "LG": return .lg
      case "NC": return .nc
      case "SSG": return .ssg
      default: return .doosan
      }
  }
}
