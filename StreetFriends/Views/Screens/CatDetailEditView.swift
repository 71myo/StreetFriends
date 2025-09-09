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
    
    init(cat: Cat) {
        _viewModel = .init(initialValue: CatDetailEditViewModel(cat: cat))
    }

    var body: some View {
        ZStack {
            Background()

            VStack(spacing: 40) {
                // MARK: - CAT HEADER IMAGE
                CatDetailHeader(imageData: viewModel.pickedPhotoData ?? viewModel.profilePhotoData,
                                mode: .fixed(maxHeight: 284))
                    .padding(.horizontal, -20)

                // MARK: - NAME SECTION
                VStack(spacing: 12) {
                    SectionHeaderView(type: .plain, title: "이름", destination: {})
                    AppInputField(text: $viewModel.name, placeholder: "8글자 이하의 이름을 입력하세요.", maxLength: 8,
                        autoFocus: false) { _ in }
                        .padding(10)
                        .frame(height: 44)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                // MARK: - FIRST DATE SECTION
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeaderView(type: .plain, title: "첫만남", destination: {})
                    DatePickerRow(date: $viewModel.firstMetDate)
                }
                
                Spacer()
                
                // MARK: - SAVE BUTTON
                PrimaryButton(kind: .save, isEnabled: viewModel.canSave && !viewModel.isSaving) {
                    let ok = viewModel.save(using: catRepository)
                    if ok { dismiss() }
                }
            } //: 전체 VSTACK
            .ignoresSafeArea()
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        } //: ZSTACK
        .overlay(alignment: .top) {
            NavigationBar(title: "",
                          style: .clear,
                          leading: { Button { dismiss() } label: { Image(.chevronLeftPaper) } },
                          trailing: { Button { isPickingPhoto = true } label: { Image(.addCatPicturePaper) } })
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
