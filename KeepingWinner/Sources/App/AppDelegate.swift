import SwiftUI
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  let winRateUseCase = WinRateUseCase.init(
    recordService: RecordDataService(),
    myTeamService: UserDefaultsService(),
    gameRecordInfoService: .live
  )
  
  let recordUseCase = AllRecordUseCase.init(
    recordService: RecordDataService()
  )
  
  let userInfoUseCase = UserInfoUseCase.init(
    myTeamService: UserDefaultsService(),
    myNicknameService: UserDefaultsService(),
    changeIconService: ChangeAppIconService(), 
    settingsService: .live
  )
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    
    TrackUserActivityManager.shared.configure(
      token: PrivateKey.getMixpanel ?? "",
      service: MixpanelService()
    )
    
    UserDefaultsService().save(data: true, key: .isPopGestureEnabled)
    
    userInfoUseCase.effect(.onAppear)
    winRateUseCase.effect(.onAppear)
    recordUseCase.effect(.onAppear)
    
    Task {
      if await ResetRecordService().transferExRecordDataToPublicVersionRecordData() {
        winRateUseCase.effect(.onAppear)
        recordUseCase.effect(.onAppear)
      }
    }
    
    let appView = AppView(
      winRateUseCase: winRateUseCase,
      recordUseCase: recordUseCase,
      userInfoUseCase: userInfoUseCase
    )
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UIHostingController(rootView: appView)
    window?.makeKeyAndVisible()
    return true
  }
}
