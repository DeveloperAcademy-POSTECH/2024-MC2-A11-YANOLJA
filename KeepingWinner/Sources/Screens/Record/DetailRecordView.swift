//
//  DetailRecordView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI
import UIKit

struct DetailRecordView: View {
  var recordUseCase: EditRecordUseCase
  
  private let editType: RecordEditType
  private let editRecord: ((RecordModel) -> Void)?
  private let newRecord: ((RecordModel) -> Void)?
  private let removeRecord: ((UUID) -> Void)?
  
  private let goBackAction: () -> Void
  
  @State private var showImagePicker = false
  @State private var selectedUIImage: UIImage?
  @State private var image: Image?
  @State private var makeBlur: Bool = false
  
  init(
    to editType: RecordEditType,
    usecase: EditRecordUseCase = .init(),
    editRecord: ((RecordModel) -> Void)? = nil,
    newRecord: ((RecordModel) -> Void)? = nil,
    removeRecord: ((UUID) -> Void)? = nil,
    goBackAction: @escaping () -> Void
  ) {
    self.editType = editType
    self.recordUseCase = usecase
    self.editRecord = editRecord
    self.newRecord = newRecord
    self.removeRecord = removeRecord
    self.goBackAction = goBackAction
  }
  
  var body: some View {
    NavigationStack {
      List {
        Section(
          "직관 정보",
          content: {
            selectDate
            
            selectStadium
            
            selectTeam
            
            toggleDoubleButton
            
          }
        )
        
        // 더블헤더 선택
        if recordUseCase.state.isDoubleHeader {
          selectDoubleHeader
        }
        
        // 경기 결과 표시
        Section(
          "경기 결과",
          content: {
            inputScoreField
            toggleCancelButton
          })
        
        // (Optional) 메모 추가
        Section(
          "메모 (선택)",
          content: {
            inputMemoField
          }
        )
        
        // (Optional) 사진 추가
        Section(
          "사진 (선택)",
          content: {
            if let image = recordUseCase.state.record.photo {
              VStack {
                if makeBlur {
                  ZStack {
                    Image(uiImage: image)
                      .resizable()
                      .scaledToFill()
                      .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.width - 50)
                      .clipped()
                      .cornerRadius(8)
                      .blur(radius: 3)
                    Image(systemName: "trash")
                      .resizable()
                      .frame(width: 36, height: 42)
                      .aspectRatio(1, contentMode: .fill)
                      .foregroundStyle(.white)
                      .onTapGesture {
                        recordUseCase.effect(.tappedPhoto)
                        makeBlur.toggle()
                      }
                  }
                } else {
                  Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.width - 50)
                    .clipped()
                    .cornerRadius(8)
                }
              }
              .frame(height: UIScreen.main.bounds.width - 50)
              .onTapGesture {
                makeBlur.toggle()
              }
            } else {
              HStack(spacing: 0) {
                Image(systemName: "plus")
                Text(" 사진 추가하기")
                Spacer()
              }
              .contentShape(Rectangle())
              .onTapGesture { showImagePicker.toggle() }
              .sheet(
                isPresented: $showImagePicker,
                onDismiss: {
                  guard let selectedUIImage else { return }
                  recordUseCase.effect(.selectPhoto(selectedUIImage))
                }) {
                  ImagePicker(image: $selectedUIImage)
                }
            }
          })
        
        if case .edit = editType {
          Button(
            action: {
              recordUseCase.effect(.tappedDeleteRecord)
              removeRecord?(recordUseCase.state.record.id)
              goBackAction()
            },
            label: {
              HStack{
                Spacer()
                Text("기록 삭제")
                  .foregroundStyle(.red)
                Spacer()
              }
            }
          )
        }
      }
      .loadingIndicator(isLoading: recordUseCase.state.networkLoading)
      .alert(
        isPresented: .init(
          get: { recordUseCase.state.teamChangeAlert },
          set: { recordUseCase.effect(._showTeamChangeAlert($0)) }
        )
      ) {
        Alert(
          title: Text("알림"),
          message: Text("모든 직관 기록은 \n 나의 직관 승률에 반영됩니다. \n 그래도 나의 팀을 변경하시겠습니까?"),
          primaryButton:
              .destructive(Text("취소")) {},
          secondaryButton:
              .default( Text("확인") ) {
                recordUseCase.effect(.tappedChangeMyTeamConfirmButton)
              }
        )
      }
      .toolbar(
        content: {
          ToolbarItem(placement: .topBarTrailing) {
            Button(
              action: {
                var new: Bool = false
                if case .new = editType { new = true }
                recordUseCase.effect(.tappedConfirmToNew(new))
                editRecord?(recordUseCase.state.record)
                newRecord?(recordUseCase.state.record)
                goBackAction()
                TrackUserActivityManager.shared
                  .effect(
                    .tappedConfirmButtonToRecord(
                      recording: recordUseCase.state.record
                    )
                  )
              },
              label: {
                Text("완료")
                  .bold()
              }
            )
          }
          ToolbarItem(placement: .topBarLeading) {
            Button(
              action: {
                goBackAction()
              },
              label: {
                Text("취소")
              }
            )
          }
        }
      )
      .tint(.black)
      .navigationTitle("오늘의 직관")
      .navigationBarTitleDisplayMode(.inline)
    }
    .task {
      recordUseCase.effect(.onAppear(editType))
    }
  }
  
  private var selectDate: some View {
    DatePicker(
      "날짜",
      selection: .init(
        get: { recordUseCase.state.record.date },
        set: { date in
          recordUseCase.effect(.tappedChangeDate(date))
        }
      ),
      in: Calendar.current
        .date(from: DateComponents(year: 2015, month: 1, day: 1))!...Date(),
      displayedComponents: [.date]
    )
  }
  
  private var selectStadium: some View {
    Picker(
      "경기장",
      selection: .init(
        get: { recordUseCase.state.record.stadium.symbol }, // 선택된 값이 Stadium 모델 자체여야 함
        set: { stadium in
          recordUseCase.effect(.tappedChangeStadium(stadium))
        }
      )
    ) {
      ForEach(recordUseCase.state.stadiums, id: \.id) { stadium in
        Text(stadium.name(year: recordUseCase.state.record.date.year))
          .tag(stadium.symbol) // tag를 Stadium 모델 전체로 설정
      }
    }
    .accentColor(.gray)
    .pickerStyle(.menu)
  }
  
  private var selectTeam: some View {
    HStack(spacing: 10) {
      SelectTeamBlock(
        type: .my,
        baseballTeams: recordUseCase.state.baseballTeams,
        year: recordUseCase.state.record.date.year,
        selectedTeamSymbol: .init(
          get: { recordUseCase.state.record.myTeam.symbol },
          set: { selected in
            recordUseCase.effect(.tappedChangeMyTeam(selected))
          }
        )
      )
      .padding(.top, 4)
      
      Text("VS")
        .font(.title2)
        .foregroundStyle(.gray)
      
      SelectTeamBlock(
        type: .vs,
        baseballTeams: recordUseCase.state.baseballTeams
          .filter { $0.symbol != recordUseCase.state.record.myTeam.symbol },
        year: recordUseCase.state.record.date.year,
        selectedTeamSymbol: .init(
          get: { recordUseCase.state.record.vsTeam.symbol },
          set: { selected in
            recordUseCase.effect(.tappedChangeVsTeam(selected))
          }
        )
      )
    }
  }
  
  private var toggleDoubleButton: some View {
    Toggle(
      isOn: .init(
        get: { recordUseCase.state.isDoubleHeader },
        set: { recordUseCase.effect(.tappedDoubleButton($0)) }
      )
    ) {
      Text("더블헤더")
    }
  }
  
  private var selectDoubleHeader: some View {
    Picker("더블헤더 선택", selection: .init(
      get: { recordUseCase.state.record.isDoubleHeader },
      set: { changeDoubleHeader in
        let isFirst = changeDoubleHeader < 1
        recordUseCase.effect(.tappedFirstDoubleButton(isFirst))
      }
    )) {
      ForEach([0, 1], id: \.self) { doubleNum in
        Text(doubleNum == 0 ? "DH1" : "DH2" )
      }
    }
    .pickerStyle(.inline)
  }
  
  private var inputScoreField: some View {
    HStack(spacing: 0) {
      Text("스코어")
        .foregroundStyle(recordUseCase.state.record.isCancel ? .gray : .black)
      Spacer()
      
      // 스코어 입력 : 취소 시 disabled
      TextField(
        "--",
        text: .init(
          get: {
            recordUseCase.state.record.myTeamScore
          },
          set: { newValue in
            recordUseCase.effect(.inputScoreMyTeam(true, newValue))
          }))
      .keyboardType(.numberPad)
      .multilineTextAlignment(.center)
      .frame(width: 94, height: 32)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .foregroundStyle(recordUseCase.state.record.isCancel ? .noTeam2.opacity(0.4) : .noTeam2)
      )
      .font(.headline)
      .foregroundStyle(recordUseCase.state.record.isCancel ? .gray : .black)
      
      Text(":")
        .foregroundStyle(recordUseCase.state.record.isCancel ? .gray.opacity(0.4) : .gray)
        .padding(.horizontal, 21)
      
      TextField(
        "--",
        text: .init(
          get: {
            recordUseCase.state.record.vsTeamScore
          },
          set: { newValue in
            recordUseCase.effect(.inputScoreMyTeam(false, newValue))
          }))
      .keyboardType(.numberPad)
      .multilineTextAlignment(.center)
      .frame(width: 94, height: 32)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .foregroundStyle(recordUseCase.state.record.isCancel ? .noTeam2.opacity(0.4) : .noTeam2)
      )
      .font(.headline)
      .foregroundStyle(recordUseCase.state.record.isCancel ? .gray : .black)
    }
    .disabled(recordUseCase.state.record.isCancel)
  }
  
  private var toggleCancelButton: some View {
    Toggle(
      isOn: .init(
        get: { recordUseCase.state.record.isCancel },
        set: { _ in recordUseCase.effect(.tappedIsCancel) }
      )
    ) {
      Text("취소")
    }
  }
  
  private var inputMemoField: some View {
    TextField("한 줄 메모를 남겨 보세요.", text: Binding(
      get: { recordUseCase.state.record.memo ?? "" },
      set: { recordUseCase.effect(.inputMemo($0)) }
    ))
    .overlay(
      alignment: .trailing,
      content: {
        Text("\(recordUseCase.state.record.memo?.count ?? 0) / 15")
          .font(.callout)
          .foregroundStyle(Color(uiColor: .systemGray2))
      }
    )
  }
}

#Preview {
  DetailRecordView(
    to: .new,
    goBackAction: { }
  )
}
