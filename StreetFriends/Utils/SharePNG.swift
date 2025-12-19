//
//  SharePNG.swift
//  StreetFriends
//
//  Created by Hyojeong on 12/15/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct SharePNG: Transferable {
    let data: Data
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .png) { $0.data }
    }
}
