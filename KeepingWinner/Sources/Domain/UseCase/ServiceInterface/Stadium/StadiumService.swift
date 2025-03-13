//
//  StadiumService.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/1/25.
//

import Foundation

struct StadiumService {
  var stadiums: () -> [StadiumModel]
}

extension StadiumService {
  static let live = Self(
    stadiums: {
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

      let stadiumDTOs = [gocheok, sagik, jamsil, suwon, incheon, daejeon, daegu, changwon, gwangju, pohang, ulsan]
      return stadiumDTOs.convert
    }
  )
}
