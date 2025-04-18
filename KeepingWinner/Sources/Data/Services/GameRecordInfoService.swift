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
          let records: [RecordModel?] = gameDTO.map { dto in
            let date = dto.date.toCalendarDate()
            let myTeam = baseballTeams.first { $0.name(year: date.year) == dto.myTeam }
            let vsTeam = baseballTeams.first { $0.name(year: date.year) == dto.vsTeam }
            let stadium = stadiums.first { $0.symbol == dto.stadium }
            
            if let myTeam, let vsTeam, let stadium {
              return RecordModel(
                date: date,
                stadium: stadium,
                isDoubleHeader: dto.doubleHeaderGameOrder,
                myTeam: myTeam,
                vsTeam: vsTeam,
                myTeamScore: dto.myTeamScore,
                vsTeamScore: dto.vsTeamScore,
                isCancel: dto.cancel
              )
            } else {
              return nil
            }
          }
          return .success(records)
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
