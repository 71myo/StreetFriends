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
    @Environment(\.dismiss) var dismiss
    let catName: String
    
    @State private var photoItem: PhotosPickerItem?
    @State private var pickedImage: UIImage? // UI 표시용
    @State private var pickedImageData: Data?
    
    @State private var note: String = ""
    
    @State private var encounterDate: Date = Date()
    
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
                              leading: { Button { dismiss() } label: { Image(.chevronLeft) } },
                              trailing: {})
                
                ScrollView {
                    VStack(spacing: 40) {
                        // MARK: - 사진 선택
                        PhotosPicker(selection: $photoItem, matching: .images) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white)
                                    .frame(height: 200)
                                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                                
                                if let ui = pickedImage {
                                    Image(uiImage: ui)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else {
                                    Image(.picture)
                                }
                            }
                            .padding(.top, 24)
                            .onChange(of: photoItem) { _, newValue in
                                guard let item = newValue else { return }
                                Task {
                                    if let data = try? await item.loadTransferable(type: Data.self),
                                       let ui = UIImage(data: data) {
                                        await MainActor.run {
                                            pickedImage = ui
                                            pickedImageData = data
                                        }
                                    }
                                }
                            }
                        }
                        
                        // MARK: - 친구 일지 섹션
                        VStack(spacing: 12) {
                            SectionHeaderView(type: .plain, title: "친구 일지") { }
                            
                            ZStack(alignment: .topLeading) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white)

                                VStack(alignment: .leading, spacing: 0) {
                                    TextEditor(text: $note)
                                        .font(.pretendard(.regular, size: 16))
                                        .foregroundStyle(.netural80)
                                        .autocorrectionDisabled()
                                        .scrollContentBackground(.hidden)
                                        .background(Color.clear)
                                        .tint(.blue50)
                                        .overlay(alignment: .topLeading) {
                                            Text("친구와의 만남을 기록해보세요.")
                                                .foregroundStyle(note.isEmpty ? .netural50 : .clear)
                                                .font(.pretendard(.medium, size: 16))
                                                .offset(x: 5, y: 8)
                                        }
                                        .padding(12)
                                        .onChange(of: note) { _, new in
                                            if new.count > 300 {
                                                note = String(new.prefix(300))
                                            }
                                        }
                                    
                                    Spacer()
                                    
                                    Text("\(note.count)/300")
                                        .font(.pretendard(.medium, size: 12))
                                        .foregroundStyle(.netural40)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.trailing, 8)
                                        .padding(.bottom, 8)
                                }
                            }
                            .frame(height: 183)
                        }
                        
                        // MARK: - 마주친 날 섹션
                        VStack(alignment: .leading, spacing: 12) {
                            SectionHeaderView(type: .plain, title: "마주친 날") { }
                            
                            
                            Text(encounterDate.formattedDot)
                                .font(.pretendard(.medium, size: 16))
                                .foregroundStyle(.netural60)
                                .padding(12)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .frame(height: 40)
                                .overlay(alignment: .trailing) {
                                    DatePicker("", selection: $encounterDate,
                                               in: ...Date(), // 미래 날짜 선택 방지
                                               displayedComponents: .date)
                                    .labelsHidden()
                                    .tint(.green60)
                                    .colorMultiply(.clear)
                            }
                        }
                        
                        PrimaryButton(kind: .save) { }
                    } //: 콘텐츠 VSTACK
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                } //: SCROLL
            } //: 전체 VSTACK
        } //: ZSTACK
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EncounterInputView(catName: "찐빵이")
}
