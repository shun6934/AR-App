//
//  CustomTableViewCell.swift
//  TwitterListApp
//
//  Created by shunichi hiraiwa on 2019/04/21.
//  Copyright © 2019 shunichi. All rights reserved.
//

import UIKit
import Accounts
import Social

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    func fill(tweet: Tweet) {
        let downloadTask = URLSession.shared.dataTask(with: URL(string: tweet.user.profileImageURL)!) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self?.iconImage.image = UIImage(data: data!)
            }
        }
        downloadTask.resume()
        
        userName.text = tweet.user.name
        screenName.text = "@" + tweet.user.screenName
        tweetContent.text = tweet.text
    }
    
}
