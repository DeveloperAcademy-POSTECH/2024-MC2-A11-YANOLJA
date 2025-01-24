import ProjectDescription
import Foundation
import ConfigPlugin

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

let fileName: String = "Yanolja"
let teamName: String = "yanolja"
let yanoljaOrganizationName: String = "com.mc2"

extension Project {
  /// Helper function to create the Project for this ExampleApp
  public static func app(name: String, destinations: Destinations, additionalTargets: [String]) -> Project {
    var targets = makeAppTargets(
      name: name,
      destinations: destinations,
      dependencies: additionalTargets.map { TargetDependency.target(name: $0) }
      + [
        .external(name: "Mixpanel")
      ]
    )
    targets += additionalTargets.flatMap({
      makeFrameworkTargets(
        name: $0,
        destinations: destinations
      )
    })
    
    return Project(
      name: name,
      organizationName: yanoljaOrganizationName,
      settings: .settings(configurations: [
        .build(.release, name: name),
        .build(.debug, name: name)
      ]),
      targets: targets,
      schemes: [
        .makeScheme(.release, name: name),
        .makeScheme(.debug, name: name)
      ],
      additionalFiles: [
        .sharedConfigPath
      ]
    )
  }
  
  // MARK: - Private
  
  /// Helper function to create a framework target and an associated unit test target
  private static func makeFrameworkTargets(name: String, destinations: Destinations) -> [Target] {
    let sources = Target(
      name: name,
      destinations: destinations,
      product: .framework,
      bundleId: "\(yanoljaOrganizationName).\(name)",
      infoPlist: .default,
      sources: ["\(name)/Sources/**"],
      resources: [
        "\(name)/Resources/**"
      ],
      dependencies: [],
      coreDataModels: [
        CoreDataModel("\(name)/Sources/Data/Baseball.xcdatamodeld")
      ]
    )
    let tests = Target(name: "\(name)Tests",
                       destinations: destinations,
                       product: .unitTests,
                       bundleId: "\(yanoljaOrganizationName).\(name)Tests",
                       infoPlist: .default,
                       sources: ["\(name)/Tests/**"],
                       resources: [],
                       dependencies: [.target(name: name)]
    )
    return [sources, tests]
  }
  
  /// Helper function to create the application target and the unit test target.
  private static func makeAppTargets(name: String, destinations: Destinations, dependencies: [TargetDependency]) -> [Target] {
    
    let mainTarget = Target(
      name: name,
      platform: .iOS,
      product: .app,
      bundleId: "\(yanoljaOrganizationName).\(teamName)",
      deploymentTarget: .iOS(targetVersion: "17.0", devices: [.iphone]),
      infoPlist: .file(path: "InfoPlist/Info.plist"),
      sources: ["\(fileName)/Sources/**"],
      resources: ["\(fileName)/Resources/**"],
      dependencies: dependencies,
      settings: .settings(configurations: [
        .build(.release, name: name),
        .build(.debug, name: name)
      ]),
      coreDataModels: [
        CoreDataModel("\(fileName)/Sources/Data/Baseball.xcdatamodeld")
      ]
    )
    
    let testTarget = Target(
      name: "\(name)Tests",
      destinations: destinations,
      product: .unitTests,
      bundleId: "\(yanoljaOrganizationName).\(teamName)Tests",
      deploymentTargets: .iOS("17.0"),
      infoPlist: .file(path: "\(fileName)/Tests/Resources/Tests-Info.plist"),
      sources: ["\(fileName)/Tests/**"],
      dependencies: [
        .target(name: "\(name)")
      ],
      settings: .settings(configurations: [
        .build(.release, name: name),
        .build(.debug, name: name)
      ])
    )
    return [mainTarget, testTarget]
  }
}
