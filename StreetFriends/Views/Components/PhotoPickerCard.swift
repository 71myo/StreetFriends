//
//  PhotoPickerCard.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI
import PhotosUI

struct PhotoPickerCard: View {
    enum Style {
        case input
        case detail
    }
    
    @Binding var image: UIImage?
    @Binding var imageData: Data?
    
    var style: Style = .input
    
    private var cornerRadius: CGFloat { style == .input ? 8 : 0 }
    private var hasShadow: Bool { style == .input }
    private var hasAnyImage: Bool {
        image != nil || imageData != nil
    }
    
    @State private var photoItem: PhotosPickerItem?
    @ScaledMetric(relativeTo: .body) private var changeIconSize: CGFloat = 24
    
    var body: some View {
        Group {
            if style == .input {
                PhotosPicker(selection: $photoItem, matching: .images) {
                    coreContent
                }.accessibilityLabel(hasAnyImage ? "사진 변경" : "사진 추가")
            } else {
                coreContent
                    .overlay(alignment: .bottomTrailing) {
                        if hasAnyImage {
                            PhotosPicker(selection: $photoItem, matching: .images) {
                                Image(.addCatPicturePaper)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: changeIconSize, height: changeIconSize)
                                    .frame(width: max(changeIconSize + 20, 44), height: max(changeIconSize + 20, 44))
                                    .contentShape(Rectangle())
                            }.accessibilityLabel("사진 변경")
                        }
                    }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(color: hasShadow ? .black.opacity(0.2) : .clear, radius: 2, x: 0, y: 2)
        .onChange(of: photoItem) { _, newValue in
            guard let item = newValue else { return }
            Task {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let ui = UIImage(data: data) {
                    await MainActor.run {
                        image = ui
                        imageData = data
                    }
                }
            }
        }
    }
    
    // MARK: - Core content(공통 뷰)
    @ViewBuilder
    private var coreContent: some View {
        Rectangle()
            .fill(Color.white)
            .frame(maxWidth: .infinity)
            .overlay {
                if let ui = image {
                    Image(uiImage: ui)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                } else if let data = imageData {
                    DataImage(data: data) { img in
                        img.resizable().scaledToFill()
                    }
                } else {
                    Image(.addCatPicture)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .foregroundStyle(.netural40)
                }
            }
    }
}

#Preview {
    PhotoPickerCard(image: .constant(nil), imageData: .constant(nil))
}
