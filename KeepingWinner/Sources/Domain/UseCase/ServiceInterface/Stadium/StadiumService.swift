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

      let stadiumDTOs = [gocheok, sagik, jamsil, suwon, incheon, daejeon, daegu, changwon, gwangju, pohang, ulsan, chugju, chugla, hanwahBall, daeguSimin, mashan, mokdong, seoul, jamsilDom, busan]
      
      return stadiumDTOs.convert
    }
  )
}
