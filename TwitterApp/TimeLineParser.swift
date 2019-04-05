//
//  TimeLineParser.swift
//  TwitterApp
//
//  Created by shunichi hiraiwa on 2017/10/03.
//  Copyright © 2017年 shunichi. All rights reserved.
//

import Foundation

struct TimelineParser {
    func parse(data: Data) -> [Tweet] {
        let serializedData = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        let json = serializedData as! [Any]
        
        let timeline: [Tweet] = json.compactMap {
            Tweet(json: $0)
        }
        
        return timeline
    }
}

