//
//  LoginCommunicator.swift
//  TwitterApp
//
//  Created by shunichi hiraiwa on 2017/10/03.
//  Copyright © 2017年 shunichi. All rights reserved.
//

import Accounts
import Social

struct LoginCommunicator {
    func login(handler: @escaping (Bool) -> ()) {
        if !SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            handler(false)
            return
        }

        let store = ACAccountStore()
        let type = store.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        store.requestAccessToAccounts(with: type, options: nil, completion: { granted, error in
            guard granted else {
                handler(false)
                return
            }

            if let _ = error {
                handler(false)
                return
            }

            let accounts = store.accounts(with: type)
            if let account = accounts?.first as? ACAccount {
                Account.twitterAccount = account
                handler(true)
            }
        })
    }
}

