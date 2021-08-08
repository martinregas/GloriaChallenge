//
//  Notification.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 22/07/2021.
//

import Foundation

enum NotificationType: String {
    case profile = "profile"
    case post = "post"
}

struct Notification {
    var id:Int
    var type:NotificationType
    var text:String
    var replacements:[String]?
    var picture:String
    var value:Int?
    var viewed:Bool
    
    var titleFormated:NSAttributedString?
}

extension Notification: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case text
        case replacements
        case picture
        case value
        case viewed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        let notificationType = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.type = NotificationType(rawValue: notificationType) ?? .post
        self.text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        self.replacements = try container.decodeIfPresent([String].self, forKey: .replacements)
        self.picture = try container.decodeIfPresent(String.self, forKey: .picture) ?? ""
        self.value = try container.decodeIfPresent(Int.self, forKey: .value)
        self.viewed = try container.decodeIfPresent(Bool.self, forKey: .viewed) ?? false
    }
}
