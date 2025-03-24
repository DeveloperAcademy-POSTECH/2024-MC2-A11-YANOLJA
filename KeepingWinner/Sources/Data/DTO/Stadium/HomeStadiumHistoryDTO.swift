//
//  HomeStadiumHistoryDTO.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/14/25.
//

import Foundation

struct HomeStadiumHistoryDTO {
  let stadium: StadiumDTO
  let startYear: Int
  let dueYear: Int?
  
  init(stadium: StadiumDTO, startYear: Int, dueYear: Int? = nil) {
    self.stadium = stadium
    self.startYear = startYear
    self.dueYear = dueYear
  }
}

extension HomeStadiumHistoryDTO {
  var convert: HomeStadiumHistory {
    HomeStadiumHistory.init(
      stadium: self.stadium.convert,
      startYear: self.startYear,
      dueYear: self.dueYear
    )
  }
}

extension Array<HomeStadiumHistoryDTO> {
  var convert: [HomeStadiumHistory] {
    return self.map { dto in dto.convert }
  }
}
