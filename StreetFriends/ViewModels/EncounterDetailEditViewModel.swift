//
//  EncounterDetailEditViewModel.swift
//  StreetFriends
//
//  Created by Hyojeong on 9/30/25.
//

import Foundation
import Observation

@Observable
final class EncounterDetailEditViewModel {
    // 입력 상태
    var note: String = ""
    var date: Date = .now
    var photoData: Data? = nil
}
