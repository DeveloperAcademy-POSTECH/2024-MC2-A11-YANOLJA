//
//  RecordDataService.swift
//  Yanolja
//
//  Created by 박혜운 on 10/1/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class RecordDataService: RecordDataServiceInterface {
  let container: NSPersistentContainer
  
  init() {
    container = NSPersistentContainer(name: "Baseball")
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
  
  // 모든 기록을 불러옵니다
  func readAllRecord(baseballTeams: [BaseballTeamModel], stadiums: [StadiumModel]) -> Result<[RecordModel], Error> {
    let recordContext = container.viewContext
    let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
    
    do {
      let fetchedRecords = try recordContext.fetch(fetchRequest)
      let gameRecords = fetchedRecords.map { recordData -> RecordModel in
        var image: UIImage? = nil
        if let photoData = recordData.photo {
          image = UIImage(data: photoData) // Data -> UIImage 변환
        }
        let myTeam = baseballTeams.find(symbol: recordData.myTeam ?? "") ?? .dummy
        let vsTeam = baseballTeams.find(symbol: recordData.vsTeam ?? "") ?? .dummy
        let stadium = stadiums.find(symbol: recordData.stadiums ?? "") ?? .dummy
        
        return RecordModel(
          id: recordData.id ?? UUID(),
          date: recordData.date ?? Date(),
          stadium: stadium,
          isDoubleHeader: Int(recordData.isDoubleHeader),
          myTeam: myTeam,
          vsTeam: vsTeam,
          myTeamScore: String(recordData.myTeamScore),
          vsTeamScore: String(recordData.vsTeamScore),
          isCancel: recordData.isCancel,
          memo: recordData.memo,
          photo: image // UIImage 반환
        )
      }
      return .success(gameRecords)
    } catch {
      return .failure(error)
    }
  }
  
  // 새로운 기록을 저장합니다
  func saveRecord(_ record: RecordModel) -> Result<VoidResponse, Error> {
    let recordContext = container.viewContext
    let newRecordData = RecordData(context: recordContext)
    
    newRecordData.id = record.id
    newRecordData.date = record.date
    newRecordData.myTeam = record.myTeam.symbol
    newRecordData.vsTeam = record.vsTeam.symbol
    newRecordData.myTeamScore = Int32(record.myTeamScore) ?? 0
    newRecordData.vsTeamScore = Int32(record.vsTeamScore) ?? 0
    newRecordData.isCancel = record.isCancel
    newRecordData.isDoubleHeader = Int32(record.isDoubleHeader)
    newRecordData.stadiums = record.stadium.symbol
    newRecordData.memo = record.memo
    
    // UIImage -> Data 변환 후 저장
    if let photo = record.photo {
      newRecordData.photo = photo.jpegData(compressionQuality: 1.0)
    }
    
    do {
      try recordContext.save()
      return .success(VoidResponse())
    } catch {
      print("Core Data 저장 실패: \(error.localizedDescription)")
      return .failure(error)
    }
  }
  
  // 기존의 기록을 수정합니다
  func editRecord(_ record: RecordModel) -> Result<VoidResponse, Error> {
    let recordContext = container.viewContext
    let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", record.id as CVarArg)
    
    do {
      let results = try recordContext.fetch(fetchRequest)
      if let recordToEdit = results.first {
        // 기존 데이터 수정
        recordToEdit.date = record.date
        recordToEdit.myTeam = record.myTeam.symbol
        recordToEdit.vsTeam = record.vsTeam.symbol
        recordToEdit.myTeamScore = Int32(record.myTeamScore) ?? 0
        recordToEdit.vsTeamScore = Int32(record.vsTeamScore) ?? 0
        recordToEdit.isCancel = record.isCancel
        recordToEdit.isDoubleHeader = Int32(record.isDoubleHeader)
        recordToEdit.stadiums = record.stadium.symbol
        recordToEdit.memo = record.memo
        
        // UIImage -> Data 변환 후 저장
        if let photo = record.photo {
          recordToEdit.photo = photo.jpegData(compressionQuality: 1.0)
        } else {
          recordToEdit.photo = nil // 사진이 없을 경우 기존 데이터를 삭제
        }
        
        try recordContext.save()
        return .success(VoidResponse())
      } else {
        return .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Record not found"]))
      }
    } catch {
      return .failure(error)
    }
  }
  
  // 기존의 기록을 삭제합니다
  func removeRecord(id: UUID) -> Result<VoidResponse, Error> {
    let recordContext = container.viewContext
    let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    
    do {
      let results = try recordContext.fetch(fetchRequest)
      if let recordToDelete = results.first {
        recordContext.delete(recordToDelete)
        try recordContext.save()
        return .success(VoidResponse())
      } else {
        return .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Record not found"]))
      }
    } catch {
      return .failure(error)
    }
  }
}
