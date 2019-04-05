//
//  ViewController.swift
//  TwitterApp
//
//  Created by shunichi hiraiwa on 2017/10/03.
//  Copyright © 2017年 shunichi. All rights reserved.
//

import UIKit
import Accounts
import Social

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LoginCommunicator().login() { isSuccess in
            switch isSuccess {
            case false:
                print("ログイン失敗")
            case true:
                print("ログイン成功")

                TwitterCommunicator().getTimeline() { [weak self] data, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    let timelineParser = TimelineParser()
                    let tweets = timelineParser.parse(data: data!)
                    print(tweets)

                    self?.tweets = tweets
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.fill(tweet: tweets[indexPath.row])
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class TableViewCell: UITableViewCell {
    
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
