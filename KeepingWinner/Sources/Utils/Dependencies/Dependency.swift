//
//  Dependency.swift
//  KeepingWinner
//
//  Created by 박혜운 on 2/12/25.
//

import Foundation

@propertyWrapper
public struct Dependency<Value: Sendable>: @unchecked Sendable {
  let keyPath: KeyPath<DependencyValues, Value>
  public init(_ keyPath: KeyPath<DependencyValues, Value>) {
    self.keyPath = keyPath
  }

  public var wrappedValue: Value {
    DependencyValues.current[keyPath: keyPath]
  }
}
