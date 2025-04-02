//
//  RecordDataService + Save.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/16/25.
//

import Foundation

extension RecordDataService: RecordUpdateServiceInterface {
  func saveRecord(
    id: UUID,
    date: Date,
    stadiumSymbol: String,
    isDoubleHeader: Int,
    myTeamSymbol: String,
    vsTeamSymbol: String,
    myTeamScore: String,
    vsTeamScore: String,
    isCancel: Bool
  ) -> Result<VoidResponse, Error> {
    
    let recordContext = container.viewContext
    let newRecordData = RecordData(context: recordContext)
    
    var myTeamSymbol = myTeamSymbol
    var vsTeamSymbol = vsTeamSymbol
    
    if myTeamSymbol == "sk" {
      myTeamSymbol = "ssg"
    } else if myTeamSymbol == "nexen" {
      myTeamSymbol = "kiwoom"
    }
    
    if vsTeamSymbol == "sk" {
      vsTeamSymbol = "ssg"
    } else if vsTeamSymbol == "nexen" {
      vsTeamSymbol = "kiwoom"
    }
    
    newRecordData.id = id
    newRecordData.date = date
    newRecordData.myTeam = myTeamSymbol
    newRecordData.vsTeam = vsTeamSymbol
    newRecordData.myTeamScore = Int32(myTeamScore) ?? 0
    newRecordData.vsTeamScore = Int32(vsTeamScore) ?? 0
    newRecordData.isCancel = isCancel
    newRecordData.isDoubleHeader = Int32(isDoubleHeader)
    newRecordData.stadiums = stadiumSymbol
    
    do {
      try recordContext.save()
      return .success(VoidResponse())
    } catch {
      return .failure(error)
    }
  }
}
