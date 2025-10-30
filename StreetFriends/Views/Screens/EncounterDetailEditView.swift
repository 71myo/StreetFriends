//
//  EncounterDetailEditView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/30/25.
//

import SwiftUI

struct EncounterDetailEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.catRepository) private var catRepository
    
    @State private var viewModel: EncounterDetailEditViewModel
    @State private var pickedImage: UIImage? // UI 표시용
    
    init(encounterID: UUID) {
        _viewModel = .init(initialValue: EncounterDetailEditViewModel(encounterID: encounterID))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Background()
            
            ScrollView {
                VStack(spacing: 40) {
                    // MARK: - 사진 섹션
                    PhotoPickerCard(image: $pickedImage, imageData: $viewModel.photoData, style: .detail)
                        .padding(.top, 24)
                        .frame(height: 335)
                    
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
            .scrollDismissesKeyboard(.immediately)
        } //: ZSTACK
        .task {
            viewModel.load(using: catRepository)
        }
        .safeAreaInset(edge: .top) {
            NavigationBar(title: viewModel.catName,
                          leading: {
                Button {
                    viewModel.onTapBack()
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
            PrimaryButton(kind: .save, isEnabled: viewModel.canSave && !viewModel.isSaving) {
                viewModel.onTapSave(using: catRepository)
            }
            .padding(.horizontal, 20).padding(.vertical, 12)
            .background(Color.white)
        }
        .onChange(of: viewModel.shouldDismiss) { _, go in
            if go { dismiss() }
        }
        .overlay {
            if viewModel.showDiscardAlert {
                CustomAlert(role: .save,
                            isPresented: $viewModel.showDiscardAlert,
                            leftAction: { dismiss() },
                            rightAction: { viewModel.confirmSaveAndDismiss(using: catRepository) })
            }
        }
    }
}

#Preview {
    let cat = Cat.previewOne
    let encounter = cat.encounters.first!
    let repo = PreviewCatRepository(cats: [cat])
    
    EncounterDetailEditView(encounterID: encounter.id)
        .environment(\.catRepository, repo)
}
