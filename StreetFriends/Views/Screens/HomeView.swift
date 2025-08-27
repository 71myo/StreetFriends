//
//  HomeView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/25/25.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTIES
    @State private var searchText: String = ""
    
    let columns = [
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4),
        GridItem(.flexible(), spacing: 4)
    ]
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                NavigationBar(title: "친구들",
                              leading: {},
                              trailing: { Button { } label: {Image(.addCat).foregroundStyle(.netural80)} })
                
                ScrollView {
                    VStack {
                        SearchBar(searchText: $searchText)
                        
                        SectionHeaderView(type: .plain,
                                          title: "가장 자주 만난 친구",
                                          destination: {})
                        .padding(.top, 32)
                        
                        PolaroidCardView(info: .home(catImage: UIImage(resource: .sampleCat),
                                                     catName: "찐빵이",
                                                     recentEncountersCount: 12),
                                         destination: {})
                        .padding(.top, 8)
                        
                        SectionHeaderView(type: .navigation,
                                          title: "즐겨찾는 친구",
                                          destination: {})
                        .padding(.top, 40)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0..<9) { cat in
                                    NavigationLink {
                                        
                                    } label: {
                                        Image(.sampleCat)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 130, height: 130)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                        SectionHeaderView(type: .navigation,
                                          title: "모든 친구",
                                          destination: {})
                        .padding(.top, 40)
                        
                        LazyVGrid(columns: columns, spacing: 4) {
                            ForEach(0..<9) { cat in
                                NavigationLink {
                                    
                                } label: {
                                    Image(.sampleCat)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 109)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                            }
                        } //: GRID
                    } //: VSTACK
                    .padding(.horizontal, 20)
                    .padding(.vertical, 18)
                } //: SCROLL
            } //: VSTACK
            .background(
                Image(.homeBackground)
                    .resizable()
                    .scaledToFill()
            )
        } //: NAVIGATION
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
