//
//  DeepLinkStore.swift
//  StreetFriends
//
//  Created by kimhyojeong on 11/5/26.
//

import Foundation
import Observation

@Observable
final class DeepLinkStore {
    static let shared = DeepLinkStore()
    var pendingCatID: UUID?
    private init() {}
}
