//
//  HomeView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/25/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Hello, World!")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("친구들")
                        .font(.pretendard(.semiBold, size: 18))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
