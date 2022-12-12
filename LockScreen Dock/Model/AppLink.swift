//
//  AppLink.swift
//  LockScreen Dock
//
//  Created by Andrei Bezlepkin on 12.12.22.
//

import SwiftUI

struct AppLink: Identifiable, Equatable, Codable, Hashable {
    var id: UUID = .init()
    var name: String
    var deepLink: String
    var status: Bool = false
    var appURL: URL?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case deepLink
        case status
        case appURL
    }
    
}

var appLinks: [AppLink] = [
    .init(name: "WhatsApp", deepLink: "whatsapp://"),
    .init(name: "ShortCuts", deepLink: "shortcuts://"),
    .init(name: "Maps", deepLink: "maps://"),
    .init(name: "Photos", deepLink: "photos-redirect://"),
    .init(name: "Google", deepLink: "http://www.google.com"),
    .init(name: "Youtube", deepLink: "http://www.youtube.com")
]
