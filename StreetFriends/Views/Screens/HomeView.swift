//
//  HomeView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/25/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                NavigationBar(title: "친구들",
                              leading: {},
                              trailing: { Button { } label: {Image(.addCat)} })
                
                ScrollView {
                    VStack {
                        Text("Hello, World!")
                    } //: VSTACK
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
