//
//  CharacterModel.swift
//  Yanolja
//
//  Created by 박혜운 on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct CharacterModel {
  var myTeam: BaseballTeam
  var totalWinRate: Int?
  
  var message: String {
    switch self.totalWinRate {
    case .none: return "직관을 기록하고 나의 승리 기여도를 확인하세요"
    case .some(let num):
      switch num {
      case 0..<26: return "언제 이길래?"
      case 26..<51: return "나 직관오지 말까…?"
      case 51..<76: return "그래 이 정도면 직관 올만해"
      default: return "나 어쩌면 승리요정일지도?"
      }
    }
  }
  
  var image: Image {
    switch self.myTeam {
    case .doosan:
      switch emotionByWinRate {
      case .none:
        return YanoljaAsset.doosanEmotion1.swiftUIImage
      case .veryBad:
        return YanoljaAsset.doosanEmotion2.swiftUIImage
      case .bad:
        return YanoljaAsset.doosanEmotion3.swiftUIImage
      case .good:
        return YanoljaAsset.doosanEmotion4.swiftUIImage
      case .excellent:
        return YanoljaAsset.doosanEmotion5.swiftUIImage
      }
      
    case .lotte:
      switch emotionByWinRate {
      case .none:
        return YanoljaAsset.lotteEmotion1.swiftUIImage
      case .veryBad:
        return YanoljaAsset.lotteEmotion2.swiftUIImage
      case .bad:
        return YanoljaAsset.lotteEmotion3.swiftUIImage
      case .good:
        return YanoljaAsset.lotteEmotion4.swiftUIImage
      case .excellent:
        return YanoljaAsset.lotteEmotion5.swiftUIImage
      }
      
    case .samsung:
      switch emotionByWinRate {
      case .none:
        return YanoljaAsset.samsungEmotion1.swiftUIImage
      case .veryBad:
        return YanoljaAsset.samsungEmotion2.swiftUIImage
      case .bad:
        return YanoljaAsset.samsungEmotion3.swiftUIImage
      case .good:
        return YanoljaAsset.samsungEmotion4.swiftUIImage
      case .excellent:
        return YanoljaAsset.samsungEmotion5.swiftUIImage
      }
      
    case .hanwha:
      switch emotionByWinRate {
      case .none:
        return YanoljaAsset.hanwhaEmotion1.swiftUIImage
      case .veryBad:
        return YanoljaAsset.hanwhaEmotion2.swiftUIImage
      case .bad:
        return YanoljaAsset.hanwhaEmotion3.swiftUIImage
      case .good:
        return YanoljaAsset.hanwhaEmotion4.swiftUIImage
      case .excellent:
        return YanoljaAsset.hanwhaEmotion5.swiftUIImage
      }
      
    case .kiwoom:
      switch emotionByWinRate {
      case .none:
        return YanoljaAsset.kiwoomEmotion1.swiftUIImage
      case .veryBad:
        return YanoljaAsset.kiwoomEmotion2.swiftUIImage
      case .bad:
        return YanoljaAsset.kiwoomEmotion3.swiftUIImage
      case .good:
        return YanoljaAsset.kiwoomEmotion4.swiftUIImage
      case .excellent:
        return YanoljaAsset.kiwoomEmotion5.swiftUIImage
      }
      
    case .kia:
      switch emotionByWinRate {
      case .none:
        return YanoljaAsset.kiaEmotion1.swiftUIImage
      case .veryBad:
        return YanoljaAsset.kiaEmotion2.swiftUIImage
      case .bad:
        return YanoljaAsset.kiaEmotion3.swiftUIImage
      case .good:
        return YanoljaAsset.kiaEmotion4.swiftUIImage
      case .excellent:
        return YanoljaAsset.kiaEmotion5.swiftUIImage
      }
      
    case .kt:
      switch emotionByWinRate {
      case .none:
        return YanoljaAsset.ktEmotion1.swiftUIImage
      case .veryBad:
        return YanoljaAsset.ktEmotion2.swiftUIImage
      case .bad:
        return YanoljaAsset.ktEmotion3.swiftUIImage
      case .good:
        return YanoljaAsset.ktEmotion4.swiftUIImage
      case .excellent:
        return YanoljaAsset.ktEmotion5.swiftUIImage
      }
      
    case .lg:
      switch emotionByWinRate {
      case .none:
        return YanoljaAsset.lgEmotion1.swiftUIImage
      case .veryBad:
        return YanoljaAsset.lgEmotion2.swiftUIImage
      case .bad:
        return YanoljaAsset.lgEmotion3.swiftUIImage
      case .good:
        return YanoljaAsset.lgEmotion4.swiftUIImage
      case .excellent:
        return YanoljaAsset.lgEmotion5.swiftUIImage
      }
      
    case .nc:
      switch emotionByWinRate {
      case .none:
        return YanoljaAsset.ncEmotion1.swiftUIImage
      case .veryBad:
        return YanoljaAsset.ncEmotion2.swiftUIImage
      case .bad:
        return YanoljaAsset.ncEmotion3.swiftUIImage
      case .good:
        return YanoljaAsset.ncEmotion4.swiftUIImage
      case .excellent:
        return YanoljaAsset.ncEmotion5.swiftUIImage
      }
      
    case .ssg:
      switch emotionByWinRate {
      case .none:
        return YanoljaAsset.ssgEmotion1.swiftUIImage
      case .veryBad:
        return YanoljaAsset.ssgEmotion2.swiftUIImage
      case .bad:
        return YanoljaAsset.ssgEmotion3.swiftUIImage
      case .good:
        return YanoljaAsset.ssgEmotion4.swiftUIImage
      case .excellent:
        return YanoljaAsset.ssgEmotion5.swiftUIImage
      }
    }
  }
  
  var emotionByWinRate: CharacterEmotionType {
    switch self.totalWinRate {
    case .none:
      return .none
    case .some(let num):
      switch num {
      case 0..<26:
        return .veryBad
      case 26..<51:
        return .bad
      case 51..<76:
        return .good
      default:
        return .excellent
      }
    }
  }
}
