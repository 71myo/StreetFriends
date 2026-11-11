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
    var placeholderSize: CGFloat? = nil
    @ViewBuilder var content: (Image) -> Content
    
    @State private var uiImage: UIImage?
    
    var body: some View {
        Group {
            if let ui = uiImage {
                content(Image(uiImage: ui))
            } else {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.netural20)
                    
                    Image(.mysteryCat)
                        .resizable()
                        .scaledToFit()
                        .frame(width: placeholderSize, height: placeholderSize)
                        .padding(placeholderSize == nil ? 10 : 0)
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
