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
    var webViewUrl: String?
    var webViewHtml: String?
    
    public init(webViewUrl: String? = String(), webViewHtml: String? = String()) {
        self.webViewUrl = webViewUrl
        self.webViewHtml = webViewHtml
    }
    
}
