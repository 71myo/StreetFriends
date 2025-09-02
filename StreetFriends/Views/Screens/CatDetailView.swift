//
//  CatDetailView.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/2/25.
//

import SwiftUI

struct CatDetailView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            Background()
            
            ScrollView {
                Image(.sampleCat)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 284)
                    .clipped()
            }
            .ignoresSafeArea()
            
            NavigationBar(title: "", style: .clear,
                          leading: { Button {} label: { Image(.chevronLeftPaper) } },
                          trailing: {
                HStack(spacing: 12) {
                    Button {} label: { Image(.selectTrue) }
                    Button {} label: { Image(.morePaper) }
                }
            })
        }
    }
}

#Preview {
    CatDetailView()
}
