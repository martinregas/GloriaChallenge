//
//  UserProfile.swift
//  GloriaAppChallenge
//
//  Created by Martin Regas on 31/07/2021.
//

import UIKit

struct UserProfile  {
    var id:Int
    var name:String
    var picture:String?
    var videoPaths:[String]
    var followersCount:Int
    var followingCount:Int
}

extension UserProfile: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case picture
        case videoPaths = "videos"
        case followersCount = "followers_count"
        case followingCount = "following_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.picture = try container.decodeIfPresent(String.self, forKey: .picture)
        self.videoPaths = try container.decodeIfPresent([String].self, forKey: .videoPaths) ?? []
        self.followersCount = try container.decodeIfPresent(Int.self, forKey: .followersCount) ?? 0
        self.followingCount = try container.decodeIfPresent(Int.self, forKey: .followingCount) ?? 0
    }
}
