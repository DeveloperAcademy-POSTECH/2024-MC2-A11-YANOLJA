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
      gameRecord: { date, myTeam, baseballTeams, stadiums in
        let result = await Provider<GameRecordInfoAPI>
          .init()
          .request(
            GameRecordInfoAPI.realRecord(date: date.asYearMonthDayWithDash, myTeam: myTeam),
            type: [BaseballGameDTO].self
          )
        
        switch result {
        case let .success(gameDTO):
          let recordList = gameDTO.map { dto in
            let myTeam = baseballTeams.first { $0.name() == dto.myTeam } ?? .dummy
            let vsTeam = baseballTeams.first { $0.name() == dto.vsTeam } ?? .dummy
            let stadium = stadiums.first { $0.symbol == dto.stadium } ?? .dummy
            
            return RecordModel(
              date: dto.date.toCalendarDate(),
              stadium: stadium,
              isDoubleHeader: dto.doubleHeaderGameOrder,
              myTeam: myTeam,
              vsTeam: vsTeam,
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
          var newWinRate: Int?
          if let winRate = winRateDto.winRate {
            newWinRate = Int((winRate) * 100)
          }
          return .success(newWinRate)
        case let .failure(error): return .failure(error)
        }
      }
    )
  }()
}
