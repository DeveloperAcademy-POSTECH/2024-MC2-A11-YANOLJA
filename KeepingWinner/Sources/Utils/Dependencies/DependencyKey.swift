//
//  DependencyKey.swift
//  KeepingWinner
//
//  Created by 박혜운 on 2/12/25.
//

import Foundation

public protocol DependencyKey {
  associatedtype Value: Sendable
  static var defaultValue: Value { get }
}

extension DependencyValues {
  public var date: @Sendable () -> Date {
    get { self[DateKey.self] }
    set { self[DateKey.self] = newValue }
  }
  public var uuid: @Sendable () -> UUID {
    get { self[UUIDKey.self] }
    set { self[UUIDKey.self] = newValue }
  }
}

private enum DateKey: DependencyKey {
  static let defaultValue = { @Sendable in Date() }
}

private enum UUIDKey: DependencyKey {
  static let defaultValue = { @Sendable in UUID() }
}
