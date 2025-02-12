//
//  DependencyValues.swift
//  KeepingWinner
//
//  Created by 박혜운 on 2/12/25.
//

import Foundation

public struct DependencyValues: Sendable {
  private var storage: [ObjectIdentifier: any Sendable] = [:]
  @TaskLocal static var current = Self()

  public subscript<Key: DependencyKey>(key: Key.Type) -> Key.Value {
    get {
      guard let dependency = self.storage[ObjectIdentifier(key)] as? Key.Value
      else {
        return Key.defaultValue
      }
      return dependency
    }
    set {
      self.storage[ObjectIdentifier(key)] = newValue
    }
  }

}
