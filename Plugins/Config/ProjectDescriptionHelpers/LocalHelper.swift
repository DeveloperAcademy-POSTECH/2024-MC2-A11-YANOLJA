import ProjectDescription

extension Configuration {
  public static func build(_ type: BuildTarget, name: String = "") -> Self {
    switch type {
    case .release:
      return .release(
        name: BuildTarget.release.configurationName,
        xcconfig: .relativeToXCConfig(type: .release)
      )
    case .debug:
      return .debug(
        name: BuildTarget.debug.configurationName,
        xcconfig: .relativeToXCConfig(type: .debug)
      )
    }
  }
}

public enum BuildTarget: String {
  case release = "Release"
  case debug = "Debug"
  
  public var configurationName: ConfigurationName {
    return ConfigurationName.configuration(self.rawValue)
  }
}

extension Path {
  public static func relativeToXCConfig(type: BuildTarget) -> Self {
    return .relativeToRoot("./Configs/\(type.rawValue).xcconfig")
  }
}

extension FileElement {
  public static var sharedConfigPath: FileElement {
    "./Configs/Shared.xcconfig"
  }
}

extension Scheme {
  
  public static func makeScheme(_ type: BuildTarget, name: String) -> Self {
    let buildName = type.rawValue
    switch type {
    case .release:
      return Scheme(
        name: "\(name)-\(buildName.uppercased())",
        buildAction: BuildAction(targets: ["\(name)"]),
        runAction: .runAction(configuration: type.configurationName),
        archiveAction: .archiveAction(configuration: type.configurationName),
        profileAction: .profileAction(configuration: type.configurationName),
        analyzeAction: .analyzeAction(configuration: type.configurationName)
      )
    case .debug:
      return Scheme(
        name: "\(name)-\(buildName.uppercased())",
        buildAction: BuildAction(targets: ["\(name)"]),
        runAction: .runAction(configuration: type.configurationName),
        archiveAction: .archiveAction(configuration: type.configurationName),
        profileAction: .profileAction(configuration: type.configurationName),
        analyzeAction: .analyzeAction(configuration: type.configurationName)
      )
    }
  }
}
