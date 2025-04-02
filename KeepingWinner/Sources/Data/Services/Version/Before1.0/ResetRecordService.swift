//
//  ResetRecordService.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/16/25.
//

import Foundation


struct ResetRecordService {
  func transferExRecordDataToPublicVersionRecordData() async -> Bool {
    let historyRecordService: RecordLoadServiceInterface = CoreDataService()
    let recordService: RecordUpdateServiceInterface = RecordDataService()
    let teamInfoService = GameRecordInfoService.live
    let stadiumService = StadiumService.live
    let baseballTeamService = BaseballTeamService.live

    guard case let .success(exRecordList) = historyRecordService
      .loadRecord() else { return false }
    guard !exRecordList.isEmpty else { return false }
    
    for exRecord in exRecordList {
      // 이전 기록을 토대로 통신 요청
      let exDate = exRecord.date

      var myTeamSymbol = exRecord.myTeamSymbol // eng
      var vsTeamSymbol = exRecord.vsTeamSymbol // eng
      var myScore = "0"
      var vsScore = "0"
      var stadiumSymbol = "고척스카이돔"
      var isDoubleHeader = -1
      var isCancel = false
      
      let result = await teamInfoService.gameRecord(
        exDate,
        convertToRealName(date: exDate, exSymbol: myTeamSymbol).uppercased(),
        baseballTeamService.teams(),
        stadiumService.stadiums()
      )

      if Int(exDate.year) ?? 2025 >= 2015, case let .success(gameDatas) = result, let gameData = gameDatas.first, let data = gameData {
        myTeamSymbol = data.myTeam.symbol
        vsTeamSymbol = data.vsTeam.symbol
        myScore = data.myTeamScore
        vsScore = data.vsTeamScore
        stadiumSymbol = data.stadium.symbol
        isDoubleHeader = data.isDoubleHeader
        isCancel = data.isCancel
      }
      
      if Int(exDate.year) ?? 2025 >= 2015 {
        // 이전 기록을 토대로 새로운 기록 저장
        _ = recordService.saveRecord(
          id: exRecord.id,
          date: exRecord.date,
          stadiumSymbol: stadiumSymbol,
          isDoubleHeader: isDoubleHeader,
          myTeamSymbol: myTeamSymbol,
          vsTeamSymbol: vsTeamSymbol,
          myTeamScore: myScore,
          vsTeamScore: vsScore,
          isCancel: isCancel
        )
      }
      
      _ = historyRecordService.removeRecord(id: exRecord.id)
    }
    
    return true
  }
  
  func convertToRealName(date: Date, exSymbol: String) -> String {
    let year = Int(date.year) ?? KeepingWinningRule.dataUpdateYear
    if year <= 2018 && exSymbol == "kiwoom" {
      return "넥센"
    } else if year <= 2020 && exSymbol == "ssg" {
      return "sk"
    } else if exSymbol == "doosan" {
      return "두산"
    } else if exSymbol == "lotte" {
      return "롯데"
    } else if exSymbol == "samsung" {
      return "삼성"
    } else if exSymbol == "hanwha" {
      return "한화"
    } else if exSymbol == "kiwoom" {
      return "키움"
    } else {
      return exSymbol
    }
  }
}
