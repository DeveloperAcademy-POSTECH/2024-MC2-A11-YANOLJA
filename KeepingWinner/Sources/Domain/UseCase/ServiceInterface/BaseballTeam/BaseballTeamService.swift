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
          .init(name: "고척스카이돔", startYear: 2016, dueYear: nil)
        ],
        startYear: 2016, dueYear: nil)
      let sagik = StadiumDTO(
        symbol: "부산사직야구장",
        histories: [
          .init(name: "부산사직야구장", startYear: 2015, dueYear: 2027)
        ],
        startYear: 2015, dueYear: 2027)
      let jamsil = StadiumDTO(
        symbol: "잠실종합운동장야구장",
        histories: [
          .init(name: "잠실종합운동장야구장", startYear: 2015, dueYear: 2026)
        ],
        startYear: 2015, dueYear: 2026)
      let suwon = StadiumDTO(
        symbol: "수원KT위즈파크",
        histories: [
          .init(name: "수원KT위즈파크", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      let incheon = StadiumDTO(
        symbol: "인천SSG랜더스필드",
        histories: [
          .init(name: "인천SK행복드림구장", startYear: 2015, dueYear: 2020),
          .init(name: "인천SSG랜더스필드", startYear: 2021, dueYear: 2027)
        ],
        startYear: 2015, dueYear: 2027)
      let daejeon = StadiumDTO(
        symbol: "대전한화생명이글스파크",
        histories: [
          .init(name: "대전한화생명이글스파크", startYear: 2015, dueYear: 2024)
        ],
        startYear: 2015, dueYear: 2024)
      let daegu = StadiumDTO(
        symbol: "대구삼성라이온즈파크",
        histories: [
          .init(name: "대구삼성라이온즈파크", startYear: 2016, dueYear: nil)
        ],
        startYear: 2016, dueYear: nil)
      let changwon = StadiumDTO(
        symbol: "창원NC파크",
        histories: [
          .init(name: "창원NC파크", startYear: 2019, dueYear: nil)
        ],
        startYear: 2019, dueYear: nil)
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
      let chugju = StadiumDTO(
        symbol: "청주종합경기장야구장",
        histories: [
          .init(name: "청주종합경기장야구장", startYear: 2015, dueYear: nil)
        ],
        startYear: 2015, dueYear: nil)
      let chugla = StadiumDTO(
        symbol: "청라돔야구장",
        histories: [
          .init(name: "청라돔야구장", startYear: 2028, dueYear: nil)
        ],
        startYear: 2028, dueYear: nil)
      let hanwahBall = StadiumDTO(
        symbol: "대전한화생명볼파크",
        histories: [
          .init(name: "대전한화생명볼파크", startYear: 2025, dueYear: nil)
        ],
        startYear: 2025, dueYear: nil)
      let daeguSimin = StadiumDTO(
        symbol: "대구시민운동장야구장",
        histories: [
          .init(name: "대구시민운동장야구장", startYear: 2015, dueYear: 2015)
        ],
        startYear: 2015, dueYear: 2015)
      let mashan = StadiumDTO(
        symbol: "마산야구장",
        histories: [
          .init(name: "마산야구장", startYear: 2015, dueYear: 2018)
        ],
        startYear: 2015, dueYear: 2018)
      let mokdong = StadiumDTO(
        symbol: "목동야구장",
        histories: [
          .init(name: "목동야구장", startYear: 2015, dueYear: 2015)
        ],
        startYear: 2015, dueYear: 2015)
      let seoul = StadiumDTO(
        symbol: "서울올림픽주경기장",
        histories: [
          .init(name: "서울올림픽주경기장", startYear: 2027, dueYear: 2031)
        ],
        startYear: 2027, dueYear: 2031)
      let jamsilDom = StadiumDTO(
        symbol: "잠실돔구장",
        histories: [
          .init(name: "잠실돔구장", startYear: 2032, dueYear: nil)
        ],
        startYear: 2032, dueYear: nil)
      let busan = StadiumDTO(
        symbol: "부산아시아드주경기장",
        histories: [
          .init(name: "부산아시아드주경기장", startYear: 2028, dueYear: 2030)
        ],
        startYear: 2028, dueYear: 2030)
      
      let doosanHome1 = HomeStadiumHistoryDTO(stadium: jamsil, startYear: 2015, dueYear: 2026)
      let doosanHome2 = HomeStadiumHistoryDTO(stadium: seoul, startYear: 2027, dueYear: 2031)
      let doosanHome3 = HomeStadiumHistoryDTO(stadium: jamsilDom, startYear: 2032)
      let lotteHome1 = HomeStadiumHistoryDTO(stadium: sagik, startYear: 2015, dueYear: 2027)
      let lotteHome2 = HomeStadiumHistoryDTO(stadium: busan, startYear: 2028, dueYear: 2030)
      let lotteHome3 = HomeStadiumHistoryDTO(stadium: sagik, startYear: 2031)
      let lotteHome4 = HomeStadiumHistoryDTO(stadium: ulsan, startYear: 2015)
      
      let samsungHome1 = HomeStadiumHistoryDTO(stadium: daeguSimin, startYear: 2015, dueYear: 2015)
      let samsungHome2 = HomeStadiumHistoryDTO(stadium: daegu, startYear: 2016)
      let samsungHome3 = HomeStadiumHistoryDTO(stadium: pohang, startYear: 2015)
      
      let hanwhaHome1 = HomeStadiumHistoryDTO(stadium: daejeon, startYear: 2015, dueYear: 2024)
      let hanwhaHome2 = HomeStadiumHistoryDTO(stadium: hanwahBall, startYear: 2025)
      let hanwhaHome3 = HomeStadiumHistoryDTO(stadium: chugju, startYear: 2015)
      
      let kiwoomHome1 = HomeStadiumHistoryDTO(stadium: mokdong, startYear: 2015, dueYear: 2015)
      let kiwoomHome2 = HomeStadiumHistoryDTO(stadium: gocheok, startYear: 2016)
      
      let kiaHome1 = HomeStadiumHistoryDTO(stadium: gwangju, startYear: 2015)
      
      let ktHome1 = HomeStadiumHistoryDTO(stadium: suwon, startYear: 2015)
      
      let lgHome1 = HomeStadiumHistoryDTO(stadium: jamsil, startYear: 2015, dueYear: 2026)
      let lgHome2 = HomeStadiumHistoryDTO(stadium: seoul, startYear: 2027, dueYear: 2031)
      let lgHome3 = HomeStadiumHistoryDTO(stadium: jamsilDom, startYear: 2032)
      
      let ncHome1 = HomeStadiumHistoryDTO(stadium: mashan, startYear: 2015, dueYear: 2018)
      let ncHome2 = HomeStadiumHistoryDTO(stadium: changwon, startYear: 2019)
      
      let ssgHome1 = HomeStadiumHistoryDTO(stadium: incheon, startYear: 2015, dueYear: 2027)
      let ssgHome2 = HomeStadiumHistoryDTO(stadium: chugla, startYear: 2028)
      
      let doosan = BaseballTeamDTO(
        symbol: "doosan",
        teamHistories: [.init(name: "두산 베어스", colorHex: "13254B", subColorHex: "CFDFFF", startYear: 2015)],
        homeHistories: [doosanHome1, doosanHome2, doosanHome3]
      )
      
      let lotte = BaseballTeamDTO(
        symbol: "lotte",
        teamHistories: [.init(name: "롯데 자이언츠", colorHex: "62AEE0", subColorHex: "D2EDFF", startYear: 2015)],
        homeHistories: [lotteHome1, lotteHome2, lotteHome3, lotteHome4]
      )
      
      let samsung = BaseballTeamDTO(
        symbol: "samsung",
        teamHistories: [.init(name: "삼성 라이온즈", colorHex: "1466B0", subColorHex: "B8DDFF", startYear: 2015)],
        homeHistories: [samsungHome1, samsungHome2, samsungHome3]
      )
      
      let hanwha = BaseballTeamDTO(
        symbol: "hanwha",
        teamHistories: [.init(name: "한화 이글스", colorHex: "F27422", subColorHex: "FDE6CB", startYear: 2015)],
        homeHistories: [hanwhaHome1, hanwhaHome2, hanwhaHome3]
      )
      
      let kiwoom = BaseballTeamDTO(
        symbol: "kiwoom",
        teamHistories: [
          .init(name: "키움 히어로즈", colorHex: "811428", subColorHex: "F3CAD1", startYear: 2019),
          .init(name: "넥센 히어로즈", colorHex: "811428", subColorHex: "F3CAD1", startYear: 2015, dueYear: 2018)
        ],
        homeHistories: [kiwoomHome1, kiwoomHome2]
      )
      
      let kia = BaseballTeamDTO(
        symbol: "kia",
        teamHistories: [.init(name: "KIA 타이거즈", colorHex: "EA0029", subColorHex: "FED2D4", startYear: 2015)],
        homeHistories: [kiaHome1]
      )
      
      let kt = BaseballTeamDTO(
        symbol: "kt",
        teamHistories: [.init(name: "KT 위즈", colorHex: "221E1F", subColorHex: "DCDADA", startYear: 2015)],
        homeHistories: [ktHome1]
      )
      
      let lg = BaseballTeamDTO(
        symbol: "lg",
        teamHistories: [.init(name: "LG 트윈스", colorHex: "C22038", subColorHex: "FFC7D0", startYear: 2015)],
        homeHistories: [lgHome1, lgHome2, lgHome3]
      )
      
      let nc = BaseballTeamDTO(
        symbol: "nc",
        teamHistories: [.init(name: "NC 다이노스", colorHex: "C39D7B", subColorHex: "F1E2D0", startYear: 2015)],
        homeHistories: [ncHome1, ncHome2]
      )
      
      let ssg = BaseballTeamDTO(
        symbol: "ssg",
        teamHistories: [
          .init(name: "SSG 랜더스", colorHex: "CD202E", subColorHex: "FFC2C7", startYear: 2021),
          .init(name: "SK 와이번스", colorHex: "CD202E", subColorHex: "FFC2C7", startYear: 2015, dueYear: 2020)
        ],
        homeHistories: [ssgHome1, ssgHome2]
      )
      
      let baseballDTOs = [doosan, lotte, samsung, kiwoom, hanwha, kia, kt, lg, nc, ssg]

      return baseballDTOs.map { $0.convert }
    }
  )
}
