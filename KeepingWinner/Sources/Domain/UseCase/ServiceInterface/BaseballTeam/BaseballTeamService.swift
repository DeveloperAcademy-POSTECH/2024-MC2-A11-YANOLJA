//
//  BaseballTeamInfoInterface.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/1/25.
//

import Foundation

struct BaseballTeamService {
  var teams: () -> [BaseballTeamModel]
}

extension BaseballTeamService {
  static let live = Self(
    teams: {
      let gocheok = StadiumDTO(
        symbol: "고척스카이돔",
        histories: [
          .init(name: "고척스카이돔", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      let sagik = StadiumDTO(
        symbol: "부산사직야구장",
        histories: [
          .init(name: "부산사직야구장", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      let jamsil = StadiumDTO(
        symbol: "잠실종합운동장야구장",
        histories: [
          .init(name: "잠실종합운동장야구장", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      let suwon = StadiumDTO(
        symbol: "수원KT위즈파크",
        histories: [
          .init(name: "수원KT위즈파크", startYear: 2015, dueYear: nil)
        ],
        latitude: 4, longitude: 0, startYear: 2015, dueYear: nil)
      let incheon = StadiumDTO(
        symbol: "인천SSG랜더스필드",
        histories: [
          .init(name: "인천SSG랜더스필드", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      let daejeon = StadiumDTO(
        symbol: "대전한화생명이글스파크",
        histories: [
          .init(name: "대전한화생명이글스파크", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      let daegu = StadiumDTO(
        symbol: "대구삼성라이온즈파크",
        histories: [
          .init(name: "대구삼성라이온즈파크", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      let changwon = StadiumDTO(
        symbol: "창원NC파크",
        histories: [
          .init(name: "창원NC파크", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      let gwangju = StadiumDTO(
        symbol: "광주KIA챔피언스필드",
        histories: [
          .init(name: "광주KIA챔피언스필드", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      let pohang = StadiumDTO(
        symbol: "포항야구장",
        histories: [
          .init(name: "포항야구장", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      let ulsan = StadiumDTO(
        symbol: "울산문수야구장",
        histories: [
          .init(name: "울산문수야구장", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      
      let doosanHome1 = HomeStadiumHistoryDTO(stadium: jamsil, startYear: 2015)
      let lotteHome1 = HomeStadiumHistoryDTO(stadium: sagik, startYear: 2015)
      let samsungHome1 = HomeStadiumHistoryDTO(stadium: daegu, startYear: 2015)
      let hanwhaHome1 = HomeStadiumHistoryDTO(stadium: daejeon, startYear: 2015)
      let kiwoomHome1 = HomeStadiumHistoryDTO(stadium: gocheok, startYear: 2015)
      let kiaHome1 = HomeStadiumHistoryDTO(stadium: gwangju, startYear: 2015)
      let ktHome1 = HomeStadiumHistoryDTO(stadium: suwon, startYear: 2015)
      let lgHome1 = HomeStadiumHistoryDTO(stadium: jamsil, startYear: 2015)
      let ncHome1 = HomeStadiumHistoryDTO(stadium: changwon, startYear: 2015)
      let ssgHome1 = HomeStadiumHistoryDTO(stadium: incheon, startYear: 2015)
      let skHome1 = HomeStadiumHistoryDTO(stadium: incheon, startYear: 2015)
      let nexenHome1 = HomeStadiumHistoryDTO(stadium: gocheok, startYear: 2015)
      
      let doosan = BaseballTeamDTO(
        symbol: "doosan",
        teamHistories: [.init(name: "두산 베어스", colorHex: "13254B", startYear: 2015)],
        homeHistories: [doosanHome1]
      )
      
      let lotte = BaseballTeamDTO(
        symbol: "lotte",
        teamHistories: [.init(name: "롯데 자이언츠", colorHex: "62AEE0", startYear: 2015)],
        homeHistories: [lotteHome1]
      )
      
      let samsung = BaseballTeamDTO(
        symbol: "samsung",
        teamHistories: [.init(name: "삼성 라이온즈", colorHex: "1466B0", startYear: 2015)],
        homeHistories: [samsungHome1]
      )
      
      let hanwha = BaseballTeamDTO(
        symbol: "hanwha",
        teamHistories: [.init(name: "한화 이글스", colorHex: "F27422", startYear: 2015)],
        homeHistories: [hanwhaHome1]
      )
      
      let kiwoom = BaseballTeamDTO(
        symbol: "kiwoom",
        teamHistories: [.init(name: "키움 히어로즈", colorHex: "811428", startYear: 2019)],
        homeHistories: [kiwoomHome1]
      )
      
      let nexen = BaseballTeamDTO(
        symbol: "kiwoom",
        teamHistories: [.init(name: "넥센 히어로즈", colorHex: "811428", startYear: 2015, dueYear: 2018)],
        homeHistories: [nexenHome1]
      )
      
      let kia = BaseballTeamDTO(
        symbol: "kia",
        teamHistories: [.init(name: "KIA 타이거즈", colorHex: "EA0029", startYear: 2015)],
        homeHistories: [kiaHome1]
      )
      
      let kt = BaseballTeamDTO(
        symbol: "kt",
        teamHistories: [.init(name: "KT 위즈", colorHex: "221E1F", startYear: 2015)],
        homeHistories: [ktHome1]
      )
      
      let lg = BaseballTeamDTO(
        symbol: "lg",
        teamHistories: [.init(name: "LG 트윈스", colorHex: "C22038", startYear: 2015)],
        homeHistories: [lgHome1]
      )
      
      let nc = BaseballTeamDTO(
        symbol: "nc",
        teamHistories: [.init(name: "NC 다이노스", colorHex: "C39D7B", startYear: 2015)],
        homeHistories: [ncHome1]
      )
      
      let ssg = BaseballTeamDTO(
        symbol: "ssg",
        teamHistories: [.init(name: "SSG 랜더스", colorHex: "CD202E", startYear: 2021)],
        homeHistories: [ssgHome1]
      )
      
      let sk = BaseballTeamDTO(
        symbol: "ssg",
        teamHistories: [.init(name: "SK 와이번스", colorHex: "CD202E", startYear: 2015, dueYear: 2020)],
        homeHistories: [ssgHome1]
      )
      
      let baseballDTOs = [doosan, lotte, samsung, hanwha, kiwoom, kia, kt, lg, nc, ssg, sk, nexen]

      return baseballDTOs.map { $0.convert }
    }
  )
}
