//
//  EncounterDetailEditView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/30/25.
//

import SwiftUI

struct EncounterDetailEditView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = EncounterDetailEditViewModel()
    @State private var pickedImage: UIImage? // UI 표시용

    var body: some View {
        ZStack(alignment: .bottom) {
            Background()
            
            ScrollView {
                VStack(spacing: 40) {
                    // MARK: - 사진 섹션
                    PhotoPickerCard(image: $pickedImage, imageData: $viewModel.photoData)
                        .padding(.top, 24)
                        .frame(height: 300)
                    
                    // MARK: - 기록 섹션
                    VStack(spacing: 4) {
                        SectionHeaderView(type: .plain, title: "기록", destination: {})
                        NoteEditorCard(text: $viewModel.note)
                            .frame(height: 183)
                    }
                    
                    // MARK: - 날짜 섹션
                    VStack(alignment: .leading, spacing: 4) {
                        SectionHeaderView(type: .plain, title: "날짜", destination: {})
                        
                        DatePickerRow(date: $viewModel.date)
                    }
                } //: CONTENTS VSTACK
                .padding(.horizontal, 20)
                .padding(.bottom, 120)
            } //: SCROLL
        } //: ZSTACK
        .safeAreaInset(edge: .top) {
            NavigationBar(title: "찐빵이",
                          leading: {
                                Button {
                                    dismiss()
                                } label: {
                                    Image(.chevronLeft)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                            },
                          trailing: {})
        }
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(kind: .save, action: {})
                .padding(.horizontal, 20).padding(.vertical, 12)
                .background(Color.white)
            
        }
    }
}

#Preview {
    EncounterDetailEditView()
}
