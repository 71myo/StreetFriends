//
//  PhotoPickerCard.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/1/25.
//

import SwiftUI
import PhotosUI

struct PhotoPickerCard: View {
    @Binding var image: UIImage?
    @Binding var imageData: Data?
    
    @State private var photoItem: PhotosPickerItem?

    var body: some View {
        PhotosPicker(selection: $photoItem, matching: .images) {
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: .infinity)
                .overlay {
                    if let ui = image {
                        Image(uiImage: ui)
                            .resizable()
                            .scaledToFill()
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
                .clipShape(RoundedRectangle(cornerRadius: 8))
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
        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    PhotoPickerCard(image: .constant(nil), imageData: .constant(nil))
}
