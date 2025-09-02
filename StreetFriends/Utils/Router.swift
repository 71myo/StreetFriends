//
//  Router.swift
//  StreetFriends
//
//  Created by Hyojeong on 8/30/25.
//

import SwiftUI
import Observation

@Observable
final class Router  {
    var path = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() { path = .init() }
}

enum Route: Hashable {
    case addCatChoice
    case catNameInput
    case encounterInput(catName: String)
}
