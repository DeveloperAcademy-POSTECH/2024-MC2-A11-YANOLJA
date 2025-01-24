//
//  Dependencies.swift
//  Config
//
//  Created by 박혜운 on 1/13/25.
//

@preconcurrency import ProjectDescription

let dependencies = Dependencies(
  swiftPackageManager: .init([
    .package(url: "https://github.com/mixpanel/mixpanel-swift.git", from: "3.1.0")
  ])
)
