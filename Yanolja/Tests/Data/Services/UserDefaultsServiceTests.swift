//
//  UserDefaultsServiceTests.swift
//  YanoljaTests
//
//  Created by 박혜운 on 9/30/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import XCTest
@testable import Yanolja

final class UserDefaultsServiceTests: XCTestCase {
  
  var userDefaultsService: UserDefaultsService!
  var testUserDefaults: UserDefaults!
  
  override func setUpWithError() throws {
    // 테스트용 UserDefaults 생성 (실제 UserDefaults에 영향을 주지 않는)
    testUserDefaults = UserDefaults(suiteName: "TestSuite")
    userDefaultsService = UserDefaultsService()
  }
  
  override func tearDownWithError() throws {
    // 테스트가 끝난 후 데이터를 모두 삭제
    testUserDefaults.removePersistentDomain(forName: "TestSuite")
    testUserDefaults = nil
    userDefaultsService = nil
  }
  
  func testSaveAndLoadMyTeam() throws {
    // 1. 테스트할 팀을 정의
    let testTeam: BaseballTeam = .doosan
    
    // 2. 저장하는 동작 테스트
    userDefaultsService.saveTeam(to: testTeam)
    
    // 3. 로드하는 동작 테스트
    let loadedTeam = userDefaultsService.readMyTeam()
    
    // 4. 저장된 값이 올바른지 확인
    XCTAssertEqual(loadedTeam, testTeam)
  }
  
  func testSaveAndLoadNickname() throws {
    // 1. 테스트할 닉네임을 정의
    let testNickname = "BaseballFan"
    
    // 2. 저장하는 동작 테스트
    userDefaultsService.save(data: testNickname, key: .myNickname)
    
    // 3. 로드하는 동작 테스트
    let loadedNickname = userDefaultsService.load(type: String.self, key: .myNickname)
    
    // 4. 저장된 닉네임이 올바른지 확인
    XCTAssertEqual(loadedNickname, testNickname)
  }
  
}
