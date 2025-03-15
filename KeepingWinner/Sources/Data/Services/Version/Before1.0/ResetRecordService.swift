//
//  ResetRecordService.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/16/25.
//

import Foundation


struct ResetRecordService {
  func transferExRecordDataToPublicVersionRecordData() async {
    let historyRecordService: RecordLoadServiceInterface = CoreDataService()
    let recordService: RecordUpdateServiceInterface = RecordDataService()
    let teamInfoService = GameRecordInfoService.live
    let stadiumService = StadiumService.live
    let baseballTeamService = BaseballTeamService.live
    guard case let .success(exRecordList) = historyRecordService
      .loadRecord() else { return }
    guard !exRecordList.isEmpty else { return }
    
    for exRecord in exRecordList {
      // 이전 기록을 토대로 통신 요청
      let exDate = exRecord.date
      let exTeam = exRecord.myTeamSymbol
      
      var myScore = "0"
      var vsScore = "0"
      var stadiumSymbol = "고척스카이돔"
      var isDoubleHeader = -1
      var isCancel = false
      
      
      let result = await teamInfoService.gameRecord(
        exDate,
        exTeam,
        baseballTeamService.teams(),
        stadiumService.stadiums()
      )

      if case let .success(gameDatas) = result, let gameData = gameDatas.first {
        myScore = gameData.myTeamScore
        vsScore = gameData.vsTeamScore
        stadiumSymbol = gameData.stadium.symbol
        isDoubleHeader = gameData.isDoubleHeader
        isCancel = gameData.isCancel
      }
      
      // 이전 기록을 토대로 새로운 기록 저장
      _ = recordService.saveRecord(
          id: exRecord.id,
          date: exRecord.date,
          stadiumSymbol: stadiumSymbol,
          isDoubleHeader: isDoubleHeader,
          myTeamSymbol: exRecord.myTeamSymbol,
          vsTeamSymbol: exRecord.vsTeamSymbol,
          myTeamScore: myScore,
          vsTeamScore: vsScore,
          isCancel: isCancel
        )
      
      _ = historyRecordService.removeRecord(id: exRecord.id)
    }
  }
}
