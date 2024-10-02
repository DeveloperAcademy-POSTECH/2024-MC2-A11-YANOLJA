import SwiftUI
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    let appView = AppView(
      winRateUseCase: .init(
        recordService: RecordDataService(),
        myTeamService: UserDefaultsService()
      ),
      recordUseCase: .init(
        recordService: RecordDataService()
      ),
      userInfoUseCase: .init(
        myTeamService: UserDefaultsService(),
        myNicknameService: UserDefaultsService(),
        changeIconService: ChangeAppIconService()
      )
    )
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UIHostingController(rootView: appView)
    window?.makeKeyAndVisible()
    return true
  }
}
