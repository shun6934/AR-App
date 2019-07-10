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
    
    // TimeLineのTweets
    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ログイン判定
        LoginCommunicator().login() { isSuccess in
            switch isSuccess {
            case false:
                print("ログイン失敗")
            case true:
                print("ログイン成功")
                
                // TimeLine取得
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! CustomTableViewCell
        cell.fill(tweet: tweets[indexPath.row])
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
