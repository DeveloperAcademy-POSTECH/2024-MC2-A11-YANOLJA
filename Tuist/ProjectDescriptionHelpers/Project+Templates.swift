import ProjectDescription
import Foundation

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

let teamName: String = "Yanolja"
let yanoljaOrganizationName: String = "com.mc2.yanolja"
let commonScripts: [TargetScript] = [
  .pre(
    script: """
    ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")
    
    ${ROOT_DIR}/swiftlint --config ${ROOT_DIR}/.swiftlint.yml
    
    """,
    name: "SwiftLint",
    basedOnDependencyAnalysis: false
  )
]

extension Project {
  /// Helper function to create the Project for this ExampleApp
  public static func app(name: String, destinations: Destinations, additionalTargets: [String]) -> Project {
    var targets = makeAppTargets(name: name,
                                 destinations: destinations,
                                 dependencies: additionalTargets.map { TargetDependency.target(name: $0) })
    targets += additionalTargets.flatMap({ makeFrameworkTargets(name: $0, destinations: destinations) })
    return Project(name: name,
                   organizationName: yanoljaOrganizationName,
                   targets: targets)
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
      resources: [],
      dependencies: []
    )
    let tests = Target(name: "\(name)Tests",
                       destinations: destinations,
                       product: .unitTests,
                       bundleId: "\(yanoljaOrganizationName).\(name)Tests",
                       infoPlist: .default,
                       sources: ["\(name)/Tests/**"],
                       resources: [],
                       dependencies: [.target(name: name)])
    return [sources, tests]
  }
  
  /// Helper function to create the application target and the unit test target.
  private static func makeAppTargets(name: String, destinations: Destinations, dependencies: [TargetDependency]) -> [Target] {
    let infoPlist: [String: Plist.Value] = [
      "CFBundleShortVersionString": "1.0",
      "CFBundleVersion": "1",
      "UILaunchStoryboardName": "LaunchScreen"
    ]
    
    let mainTarget = Target(
      name: name,
      destinations: destinations,
      product: .app,
      bundleId: "\(yanoljaOrganizationName).\(name)",
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["\(name)/Sources/**"],
      resources: ["\(name)/Resources/**"],
      scripts: commonScripts,
      dependencies: dependencies
    )
    
    let testTarget = Target(
      name: "\(name)Tests",
      destinations: destinations,
      product: .unitTests,
      bundleId: "\(yanoljaOrganizationName).\(name)Tests",
      infoPlist: .default,
      sources: ["\(name)/Tests/**"],
      dependencies: [
        .target(name: "\(name)")
      ])
    return [mainTarget, testTarget]
  }
}
