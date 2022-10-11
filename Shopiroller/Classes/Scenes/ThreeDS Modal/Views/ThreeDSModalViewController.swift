//
//  ThreeDSModalViewController.swift
//  Shopiroller
//
//  Created by Emre Can Altaca on 8.11.2021.
//

import Foundation
import UIKit
import WebKit
import SVProgressHUD


protocol ThreeDSModalDelegate:AnyObject {
    func onPaymentSuccess()
    func onPaymentFailed(message: String?)
}

class ThreeDSModalViewController: BaseViewController<ThreeDSModalViewModel> {
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var containerView: UIView!
    
    weak var delegate: ThreeDSModalDelegate?
    
    init(viewModel: ThreeDSModalViewModel){
        super.init(viewModel: viewModel, nibName: ThreeDSModalViewController.nibName, bundle: Bundle(for: ThreeDSModalViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        containerView.backgroundColor = .white
        
        webView.navigationDelegate = self
        webView.loadHTMLString(viewModel.getRedirectUrl() ?? "", baseURL: nil)

    }
}


extension ThreeDSModalViewController: WKNavigationDelegate {
    
    internal func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        delegate?.onPaymentFailed(message: "")
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
       
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let _ = webView.url else { return }
        guard let url = navigationAction.request.url else {
                        decisionHandler(.allow)
                        return
                    }
        if viewModel.isPageFinished(url: url.absoluteString) {
            webView.removeFromSuperview()
            self.pop(animated: true, completion: nil)
            if ((SRSessionManager.shared.orderResponseInnerModel?.payment?.isSuccess ?? false) == true) {
                delegate?.onPaymentSuccess()
            } else {
                delegate?.onPaymentFailed(message: viewModel.getErrorMessage())
            }
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
}
