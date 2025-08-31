//
//  EncounterInputView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/29/25.
//

import SwiftUI
import PhotosUI

struct EncounterInputView: View {
    // MARK: - PROPERTIES
    @Environment(\.catRepository) private var catRepository
    @Environment(Router.self) private var router
    @State private var viewModel = EncounterInputViewModel()

    let catName: String
    @State private var pickedImage: UIImage? // UI 표시용
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image(.homeBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.keyboard)
            } //: GEOMETRY
            
            VStack(spacing: 0) {
                NavigationBar(title: catName,
                              leading: { Button { router.pop() } label: { Image(.chevronLeft) } },
                              trailing: {})
                
                VStack(spacing: 32) {
                    // MARK: - 사진 선택
                    PhotoPickerCard(image: $pickedImage, imageData: $viewModel.photoData)
                    .padding(.top, 24)
                    
                    // MARK: - 친구 일지 섹션
                    VStack(spacing: 12) {
                        SectionHeaderView(type: .plain, title: "친구 일지") { }
                        
                        NoteEditorCard(text: $viewModel.note, placeholder: "친구와의 만남을 기록해보세요.")
                            .frame(height: 183)
                    }
                    
                    // MARK: - 마주친 날 섹션
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeaderView(type: .plain, title: "마주친 날") { }
                        
                        
                        DatePickerRow(date: $viewModel.date)
                    }
                    
                    PrimaryButton(kind: .save, isEnabled: viewModel.canSave && !viewModel.isSaving) {
                        viewModel.name = catName
                        let ok = viewModel.saveNewCatEncounter(using: catRepository)
                        if ok {
                            router.popToRoot()
                        }
                    }
                } //: 콘텐츠 VSTACK
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            } //: 전체 VSTACK
        } //: ZSTACK
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EncounterInputView(catName: "찐빵이")
        .environment(Router())
}
