//
//  ShareCardView.swift
//  KeepingWinner
//
//  Created by 유지수 on 3/22/25.
//

import SwiftUI
import Photos

struct ShareCardView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var userInfoUseCase: UserInfoUseCase
  let characterModel: CharacterModel
  
  @Binding var cardButtonTapped: Bool
  @State private var saveState: SaveState = .idle
  
  var body: some View {
    ZStack {
      DarkBlurView(blurRadius: 20)
        .ignoresSafeArea()
      
      VStack(spacing: 0) {
        VStack(alignment: .trailing, spacing: 0) {
          Button(action: {
            cardButtonTapped = false
          }) {
            Image(systemName: "xmark")
              .font(.callout)
              .bold()
              .foregroundStyle(.white)
          }
          .padding(.bottom, 8)
          
          CardView(
            recordWinRate: winRateUseCase.state.recordWinRate,
            myTeam: userInfoUseCase.state.myTeam.name(type: .full),
            myNickname: userInfoUseCase.state.myNickname,
            characterModel: characterModel
          )
        }
        .padding(.bottom, 16)
        
        HStack(spacing: 0) {
          saveButton
          
          Spacer().frame(width: 8)
          
          shareButton
        }
      }
      
      if saveState == .saving {
        overlayView("저장 중...")
      } else if saveState == .saved {
        overlayView("저장됨", systemImage: "checkmark")
      }
    }
  }
  
  private var saveButton: some View {
    Button(action: {
      DispatchQueue.main.async {
        let image = CardView(
          recordWinRate: winRateUseCase.state.recordWinRate,
          myTeam: userInfoUseCase.state.myTeam.name(type: .full),
          myNickname: userInfoUseCase.state.myNickname,
          characterModel: characterModel
        )
          .drawingGroup()
          .asUIImage(size: CGSize(width: 280, height: 470))
          .clipped(cornerRadius: 20)
        
        saveImageToAlbum(image)
      }
    }) {
      Label("이미지 저장", image: .saveIcon)
        .font(.callout.bold())
        .padding(.horizontal, 26.5)
        .padding(.vertical, 12.5)
        .foregroundStyle(.white)
        .background(.black)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
  }
  
  private var shareButton: some View {
    Button(action: {
      
    }) {
      Label("스토리 공유", image: .instagramIcon)
        .font(.callout.bold())
        .padding(.horizontal, 26.5)
        .padding(.vertical, 12.5)
        .foregroundStyle(.white)
        .background(.black)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
  }
  
  private func overlayView(_ text: String, systemImage: String? = nil) -> some View {
    Rectangle()
      .foregroundStyle(.ultraThinMaterial)
      .ignoresSafeArea()
      .overlay(
        VStack(spacing: 23) {
          if let systemImage = systemImage {
            Image(systemName: systemImage)
              .font(.system(size: 64, weight: .semibold))
              .foregroundStyle(.secondary)
          } else {
            ActivityIndicator(isAnimating: .constant(true), style: .large)
          }
          
          Text(text)
            .font(.callout)
            .foregroundStyle(Color.primary)
        }
        .frame(width: 155, height: 157)
        .background(.regularMaterial)
        .cornerRadius(8)
      )
  }
  
  private func saveImageToAlbum(_ image: UIImage) {
    saveState = .saving
    
    PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
      guard status == .authorized else {
        saveState = .idle
        return
      }
      
      UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
      
      DispatchQueue.main.async {
        saveState = .saved
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          saveState = .idle
        }
      }
    }
  }
}

enum SaveState {
  case idle, saving, saved
}

#Preview {
  ShareCardView(
    winRateUseCase: .init(
      recordService: RecordDataService(),
      myTeamService: UserDefaultsService(),
      gameRecordInfoService: .live
    ),
    userInfoUseCase: .init(
      myTeamService: UserDefaultsService(), myNicknameService: UserDefaultsService(),
      changeIconService: ChangeAppIconService(),
      settingsService: .preview
    ),
    characterModel: .init(
      symbol: KeepingWinningRule.noTeamSymbol,
      colorHex: KeepingWinningRule.noTeamColorHex,
      totalWinRate: 100
    ),
    cardButtonTapped: .constant(true)
  )
}
