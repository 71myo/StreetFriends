//
//  HomeView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/25/25.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTY
    @State private var searchText: String = ""
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                NavigationBar(title: "친구들",
                              leading: {},
                              trailing: { Button { } label: {Image(.addCat)} })
                
                ScrollView {
                    VStack {
                        SearchBar(searchText: $searchText)
                        
                        Text("가장 자주 만난 친구")
                            .font(.pretendard(.semiBold, size: 18))
                            .foregroundStyle(.netural80)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 32)
                        
                        PolaroidCardView(info: .home(catImage: UIImage(resource: .sampleCat),
                                                     catName: "찐빵이",
                                                     recentEncountersCount: 12))
                        .padding(.top, 8)
                    } //: VSTACK
                    .padding(.horizontal, 20)
                    .padding(.top, 18)
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
