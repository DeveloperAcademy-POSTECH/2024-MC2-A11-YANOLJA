//
//  CoreDataService.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation
import CoreData

// MARK: - 에디꺼
/// Service: 코어 데이터에 접근하는 로직이 존재하는 공간
struct CoreDataService: DataServiceInterface {
  
  private let container: NSPersistentContainer
  
  init() {
    container = NSPersistentContainer(name: "Baseball")
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
  
  func saveRecord(_ record: GameRecordModel) -> Result<VoidResponse, Error> {
    let context = container.viewContext
    let newRecord = GameRecord(context: context)
  
    newRecord.id = record.id
    newRecord.date = record.date
    newRecord.myTeam = record.myTeam.rawValue
    newRecord.vsTeam = record.vsTeam.rawValue
    newRecord.stadiums = record.stadiums.rawValue
    newRecord.result = record.result.rawValue
          
    do {
      try context.save()
      return .success(VoidResponse())
    } catch {
        return .failure(error)
      }
  }
  
  func readAllRecord() -> Result<[GameRecordModel], Error> {
    let context = container.viewContext
    let request: NSFetchRequest<GameRecord> = GameRecord.fetchRequest()
    
    do {
      let records = try context.fetch(request)
      let gameRecords = records.map { record -> GameRecordModel in
        GameRecordModel(
          id: record.id ?? UUID(),
          date: record.date ?? Date(),
          myTeam: BaseballTeam(rawValue: record.myTeam ?? "") ?? .myTeam,
          vsTeam: BaseballTeam(rawValue: record.vsTeam ?? "") ?? .myTeam,
          stadiums: BaseballStadiums(rawValue: record.stadiums ?? "") ?? .jamsil,
          gameResult: GameResult(rawValue: record.result ?? "") ?? .win
        )
      }
      return .success(gameRecords)
    } catch {
      return .failure(error)
    }
  }
  
  func editRecord(_ record: GameRecordModel) -> Result<VoidResponse, Error> {
    let context = container.viewContext
    let request: NSFetchRequest<GameRecord> = GameRecord.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", record.id as CVarArg)
    
    do {
      let records = try context.fetch(request)
      if let existingRecord = records.first {
        existingRecord.date = record.date
        existingRecord.myTeam = record.myTeam.rawValue
        existingRecord.vsTeam = record.vsTeam.rawValue
        existingRecord.stadiums = record.stadiums.rawValue
        existingRecord.result = record.result.rawValue
        
        try context.save()
        return .success(VoidResponse())
      } else {
        return .failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "래코드가 없습니다."]))
      }
    } catch {
      return .failure(error)
    }
  }
  
  // 레코드 삭제
  func removeRecord(id: UUID) -> Result<VoidResponse, Error> {
    let context = container.viewContext
    let request: NSFetchRequest<GameRecord> = GameRecord.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    do {
      let records = try context.fetch(request)
      if let recordToDelete = records.first {
        context.delete(recordToDelete)
        
        try context.save()
        return .success(VoidResponse())
      } else {
        return .failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "래코드가 없습니다."]))
      }
    } catch {
      return .failure(error)
    }
  }
}

