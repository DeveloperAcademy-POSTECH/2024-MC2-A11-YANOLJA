//
//  GameRecord+CoreDataProperties.swift
//  Yanolja
//
//  Created by jhon on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//
//

import CoreData
import Foundation
// 커식 이해용 수정

extension GameRecord: Identifiable {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<GameRecord> {
    return NSFetchRequest<GameRecord>(entityName: "GameRecord")
  }
  
  @NSManaged public var date: Date?
  @NSManaged public var myTeam: String?
  @NSManaged public var result: String?
  @NSManaged public var stadiums: String?
  @NSManaged public var id: UUID?
  @NSManaged public var vsTeam: String?
  
}
