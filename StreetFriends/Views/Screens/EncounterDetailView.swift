//
//  EncounterDetailView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/18/25.
//

import SwiftUI

struct EncounterDetailView: View {
    // MARK: - PROPERTIES
    @Environment(\.catRepository) private var catRepository
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: EncounterDetailViewModel
    
    init(encounterID: UUID) {
        _viewModel = .init(initialValue: EncounterDetailViewModel(encounterID: encounterID))
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            Background()
            
            ScrollView {
                // 콘텐츠 VSTACK
                VStack(spacing: 0) {
                    Text(viewModel.dateText)
                        .font(.pretendard(.medium, size: 16))
                        .foregroundStyle(.netural60)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    DataImage(data: viewModel.photoData) { img in
                        img
                            .resizable()
                            .scaledToFill()
                            .frame(height: 335)
                            .clipped()
                    }
                    .padding(.top, 4)
                    
                    Text(viewModel.note)
                        .font(.pretendard(.medium, size: 16))
                        .lineSpacing(4)
                        .foregroundStyle(.netural80)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } //: VSTACK
            } //: SCROLL
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        } //: ZSTACK
        .task {
            viewModel.load(using: catRepository)
        }
        .safeAreaInset(edge: .top) {
            NavigationBar(title: viewModel.catName,
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
                          trailing: {
                HStack(spacing: 4) {
                    Button {
                        
                    } label: {
                        Image(.selectTrue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    
                    Menu {
                        NavigationLink {
                            
                        } label: {
                            Text("추억 수정")
                        }
                        
                        Button("추억 공유") {
                            
                        }
                        
                        Button("삭제하기") {
                            
                        }
                    } label: {
                        Image(.more)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
            })
        }
    }
}

#Preview {
    let cat = Cat.previewOne
    let encounter = cat.encounters.first!
    let repo = PreviewCatRepository(cats: [cat])
    
    EncounterDetailView(encounterID: encounter.id)
        .environment(\.catRepository, repo)
}
