//
//  CoreDataService.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import CoreData
import Foundation

struct CoreDataService {
  private let container: NSPersistentContainer
  
  init() {
    container = NSPersistentContainer(name: "Baseball")
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
  
  private func saveRecord() -> Result<VoidResponse, Error> {
    let context = container.viewContext
    let newRecord = GameRecord(context: context)
    
    let dateString = "24-08-14"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yy-MM-dd"
    let date = dateFormatter.date(from: dateString) ?? .now
    
    newRecord.id = .init()
    newRecord.date = date
    newRecord.myTeam = "kiwoom"
    newRecord.vsTeam = "doosan"
    newRecord.stadiums = "gocheok"
    newRecord.result = "win"
    
    do {
      try context.save()
      return .success(VoidResponse())
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

extension CoreDataService: RecordLoadServiceInterface {
  func loadRecord() -> Result<[(id: UUID, date: Date, stadiumRawValue: String, myTeamSymbol: String, vsTeamSymbol: String)], any Error> {
    let context = container.viewContext
    let request: NSFetchRequest<GameRecord> = GameRecord.fetchRequest()
    
    do {
      let records = try context.fetch(request)
      let gameRecords = records.map { record -> (
        id: UUID,
        date: Date,
        stadiumRawValue: String,
        myTeamSymbol: String,
        vsTeamSymbol: String
      ) in
        return (
          id: record.id ?? UUID(),
          date: record.date ?? Date(),
          stadiumRawValue: record.stadiums ?? "",
          myTeamSymbol: record.myTeam ?? "",
          vsTeamSymbol: record.vsTeam ?? ""
        )
      }
      return .success(gameRecords)
    } catch {
      print(error.localizedDescription)
      return .failure(error)
    }
  }
}
