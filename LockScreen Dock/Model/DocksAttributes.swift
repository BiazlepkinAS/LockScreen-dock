//
//  DocksAttributes.swift
//  LockScreen Dock
//
//  Created by Andrei Bezlepkin on 12.12.22.
//

import SwiftUI
import ActivityKit

struct DockAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
    }
    var name: String
    var addedLinks: [AppLink]
}
