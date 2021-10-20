//
//  WebViewControllerViewModel.swift
//  Shopiroller
//
//  Created by Görkem on 16.10.2021.
//

import Foundation
import SafariServices
import WebKit

public class WebViewViewModel {
    public var webViewUrl: String
    
    public init(webViewUrl: String = "") {
        self.webViewUrl = webViewUrl
    }
    
}
