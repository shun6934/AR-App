//
//  Tweet.swift
//  TwitterApp
//
//  Created by shunichi hiraiwa on 2017/10/03.
//  Copyright © 2017年 shunichi. All rights reserved.
//

import Foundation

struct Tweet {
    
    let id: String
    let text: String
    let user: User
    
    init?(json: Any) {
        guard let dictionary = json as? [String: Any] else { return nil }

        guard let id = dictionary["id_str"] as? String else { return nil }
        guard let text = dictionary["text"] as? String else { return nil }
        guard let userJSON = dictionary["user"] else { return nil }
        guard let user = User(json: userJSON) else { return nil }

        self.id = id
        self.text = text
        self.user = user
    }
    
}

struct User {
    
    let id: String
    let screenName: String
    let name: String
    let profileImageURL: String
    
    init?(json: Any) {
        guard let dictionary = json as? [String: Any] else { return nil }

        guard let id = dictionary["id_str"] as? String else { return nil }
        guard let screenName = dictionary["screen_name"] as? String else { return nil }
        guard let name = dictionary["name"] as? String else { return nil }
        guard let profileImageURL = dictionary["profile_image_url_https"] as? String else { return nil }

        self.id = id
        self.screenName = screenName
        self.name = name
        self.profileImageURL = profileImageURL
    }
    
}
