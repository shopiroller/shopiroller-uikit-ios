//
//  SRNetworkManagerURLSessionDelegate.swift
//  shopiroller
//
//  Created by Görkem Gür on 16.09.2021.
//

import Foundation


import Foundation

final class SRNetworkManagerURLSessionDelegate: NSObject { }

extension SRNetworkManagerURLSessionDelegate: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
        }
    }
}
