//
//  CatDetailViewModel.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/6/25.
//

import SwiftUI
import Observation

@Observable
final class CatDetailViewModel {
    var cat: Cat
    var isWorking: Bool = false
    var error: String?
    
    var shareItem: SharePNG?
    var sharePreviewImage: UIImage?
    
    init(cat: Cat) {
        self.cat = cat
    }
    
    @MainActor
    func togggleFavorite(using repo: CatRepository) {
        guard !isWorking else { return }
        isWorking = true
        defer { isWorking = false }
        
        do {
            try repo.setFavorite(cat, isFavorite: !cat.isFavorite)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    @MainActor
    func delete(repo: CatRepository) {
        do {
            try repo.deleteCat(cat)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func makeEditorViewModel() -> CatDetailEditViewModel {
        .init(cat: cat)
    }
    
    @MainActor
    func prepareShareCard(scale: CGFloat) {
        guard #available(iOS 16.0, *) else { return }

        let count = cat.encounters.count
        let photo = cat.profilePhoto.flatMap(UIImage.init)
        
        let card = PolaroidShareCardView(
            mode: .cat(photo: photo, name: cat.name, totalEncountersCount: count)
        )
        
        let renderer = ImageRenderer(content: card)
        renderer.proposedSize = .init(width: card.cardWidth, height: card.cardHeight)
        renderer.scale = scale

        guard let uiImage = renderer.uiImage,
              let png = uiImage.pngData()
        else { return }

        self.shareItem = SharePNG(data: png)
        self.sharePreviewImage = uiImage
    }
}
