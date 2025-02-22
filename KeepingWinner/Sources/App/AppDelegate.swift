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
  
  let recordUseCase = RecordUseCase.init(
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
    
    Task {
      await loadStadiumsInfo()
      await transferExRecordDataToPublicVersionRecordData()
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
  
  func transferExRecordDataToPublicVersionRecordData() async {
    let historyRecordService = CoreDataService()
    let recordService = RecordDataService()
    let teamInfoService = GameRecordInfoService.live
    guard case let .success(exRecordList) = historyRecordService.readAllRecord() else { return }
    guard !exRecordList.isEmpty else { return }
    
    for exRecord in exRecordList {
      // 이전 기록을 토대로 통신 요청
      let exDate = exRecord.date
      let exTeam = exRecord.myTeam.sliceName
      
      var myScore = "0"
      var vsScore = "0"
      var stadiums = exRecord.stadiums.convertName
      var isDoubleHeader = -1
      var isCancel = false
      
      let result = await teamInfoService.gameRecord(exDate, exTeam)

      if case let .success(gameDatas) = result, let gameData = gameDatas.first {
        myScore = gameData.myTeamScore
        vsScore = gameData.vsTeamScore
        stadiums = gameData.stadiums
        isDoubleHeader = gameData.isDoubleHeader
        isCancel = gameData.isCancel
      }
      
      // 이전 기록을 토대로 새로운 기록 생성
      let convertRecord = GameRecordWithScoreModel(
        id: exRecord.id,
        date: exRecord.date,
        stadiums: stadiums,
        myTeam: exRecord.myTeam,
        vsTeam: exRecord.vsTeam,
        isDoubleHeader: isDoubleHeader,
        myTeamScore: myScore,
        vsTeamScore: vsScore,
        isCancel: isCancel
    )
      
      // 이전 기록을 토대로 새로운 기록 저장
      _ = recordService.saveRecord(convertRecord)
      
      // 이전 기록 삭제
      _ = historyRecordService.removeRecord(id: exRecord.id)
      let recordList = recordUseCase.state.recordList

      await MainActor.run {
        self.recordUseCase.effect(.renewAllRecord)
        self.winRateUseCase.effect(.updateRecords(recordList))
      }
    }
  }
  
  func loadStadiumsInfo() async {
    guard case let .success(stadiums) = await SettingsService.live.allStadiums() else { return }
    BaseballStadiums.nameList = stadiums
  }
}
