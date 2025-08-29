//
//  EncounterInputView.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/29/25.
//

import SwiftUI

struct EncounterInputView: View {
    let catName: String
    
    var body: some View {
        Text(catName)
    }
}

#Preview {
    EncounterInputView(catName: "찐빵이")
}
