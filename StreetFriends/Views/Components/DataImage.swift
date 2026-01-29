//
//  DataImage.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/5/25.
//

import SwiftUI

struct DataImage<Content: View>: View {
    let data: Data?
    var fixedHeight: CGFloat?
    @ViewBuilder var content: (Image) -> Content
    
    @State private var uiImage: UIImage?
    
    var body: some View {
        Group {
            if let ui = uiImage {
                content(Image(uiImage: ui))
            } else {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.netural30)
                    
                    Image(.mysteryCat)
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                }
            }
        }
        .frame(height: fixedHeight)
        .clipped()
        .task { uiImage = data.flatMap(UIImage.init) }
        .onChange(of: data) { _, newValue in
            uiImage = newValue.flatMap(UIImage.init)
        }
    }
}
