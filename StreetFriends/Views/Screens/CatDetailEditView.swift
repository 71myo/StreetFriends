//
//  CatDetailEditView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/8/25.
//

import SwiftUI
import PhotosUI

struct CatDetailEditView: View {
    @Environment(\.catRepository) private var catRepository
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: CatDetailEditViewModel
    
    @State private var isPickingPhoto = false
    @State private var pickerItem: PhotosPickerItem?
    @FocusState private var nameFocused: Bool
    
    init(cat: Cat) {
        _viewModel = .init(initialValue: CatDetailEditViewModel(cat: cat))
    }

    var body: some View {
        ZStack {
            Background()

            ScrollView {
                VStack(spacing: 0) {
                    // MARK: - CAT HEADER IMAGE
                    CatDetailHeader(imageData: viewModel.currentPhotoData,
                                    mode: .fixed(maxHeight: 284))
                    .padding(.horizontal, -20)
                    
                    // MARK: - NAME SECTION
                    VStack(spacing: 12) {
                        SectionHeaderView(type: .plain, title: "이름", destination: {})
                        AppInputField(text: $viewModel.name,
                                      placeholder: "8글자 이하의 이름을 입력하세요.",
                                      maxLength: 8,
                                      autoFocus: false,
                                      externalFocus: $nameFocused) { _ in }
                            .padding(10)
                            .frame(height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(.top, 40)
                    
                    // MARK: - FIRST DATE SECTION
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeaderView(type: .plain, title: "첫만남", destination: {})
                        DatePickerRow(date: $viewModel.firstMetDate)
                    }
                    .padding(.top, 40)
                } //: 전체 VSTACK
                .padding(.horizontal, 20)
                .contentShape(Rectangle())
                .onTapGesture { nameFocused = false }
            } //: SCROLLVIEW
            .safeAreaInset(edge: .bottom) {
                PrimaryButton(kind: .save,
                              isEnabled: viewModel.canSave && !viewModel.isSaving) {
                    viewModel.onTapSave(using: catRepository)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            }
            .scrollDisabled(true)
            .ignoresSafeArea(edges: .top)
        } //: ZSTACK
        .safeAreaInset(edge: .top) {
            NavigationBar(title: "",
                          style: .clear,
                          leading: { Button { viewModel.onTapBack() } label: { Image(.chevronLeftPaper) } },
                          trailing: { Button { isPickingPhoto = true } label: { Image(.addCatPicturePaper) } })
        }
        .overlay {
            if viewModel.showDiscardAlert {
                CustomAlert(role: .save,
                            isPresented: $viewModel.showDiscardAlert) {
                    viewModel.cancelDiscard()
                    dismiss()
                } rightAction: {
                    viewModel.confirmSaveAndDismiss(using: catRepository)
                }
            }
        }
        .onChange(of: viewModel.shouldDismiss) { _, go in
            if go {
                dismiss()
                viewModel.shouldDismiss = false
            }
        }
        .photosPicker(isPresented: $isPickingPhoto, selection: $pickerItem)
        .onChange(of: pickerItem) { _, newItem in
            guard let item = newItem else { return }
            Task {
                if let data = try? await item.loadTransferable(type: Data.self) {
                    await MainActor.run {
                        viewModel.pickedPhotoData = data
                    }
                }
            }
        }
    }
}

#Preview {
    CatDetailEditView(cat: .previewOne)
}

