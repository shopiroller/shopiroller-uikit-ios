//
//  SRRequestManager.swift
//  shopiroller
//
//  Created by Görkem Gür on 16.09.2021.
//

import Foundation

struct SRNetworkRequestManager<T: Decodable> {
    var httpMethod: SRNetworkManagerHttpMethods?
    var path: SRNetworkManagerPaths
    var contentType: SRNetworkManagerContentType
    var subpath: String?
    var urlQueryItems: [URLQueryItem]?
    var httpBody: Data?
    var shouldShowProgressHUD: Bool
    var shouldBlockUI: Bool
    var otpTokenRequired: Bool
    var ignoreParse: Bool
    var ignoreBaseModel: Bool
    var isUser: Bool

    init(httpMethod: SRNetworkManagerHttpMethods? = nil, path: SRNetworkManagerPaths, contentType: SRNetworkManagerContentType = .json, subpath: String? = nil, resourceType: T.Type, urlQueryItems: [URLQueryItem]? = nil, httpBody: Data? = nil, shouldShowProgressHUD: Bool = true, shouldBlockUI: Bool = true, otpTokenRequired: Bool = false, ignoreParse: Bool = false, ignoreBaseModel : Bool = false, isUser :Bool = false) {
        self.httpMethod = httpMethod
        self.path = path
        self.contentType = contentType
        self.subpath = subpath
        self.urlQueryItems = urlQueryItems
        self.httpBody = httpBody
        self.shouldShowProgressHUD = shouldShowProgressHUD
        self.shouldBlockUI = shouldBlockUI
        self.otpTokenRequired = otpTokenRequired
        self.ignoreParse = ignoreParse
        self.ignoreBaseModel = ignoreBaseModel
        self.isUser = isUser
    }
}

extension SRNetworkRequestManager {
    func response(response: @escaping ((SRResponseResult<SRNetworkManagerResponse<T>>) -> Void)) {
        BaseViewModel.networkManager.response(for: self) { result in
            switch result {
            case .success:
                response(result)
            case .failure(let err):
                response(result)
            }
        }
    }

    func objectResponse(using api: SRNetworkManager, response: @escaping ((SRResponseResult<SRNetworkManagerResponse<T>>) -> Void)) {
        api.objectResponse(for: self) { result in
            switch result {
            case .success(let responseObject):
                let networkManagerResponse: SRNetworkManagerResponse<T> = SRNetworkManagerResponse(data: responseObject, isUserFriendlyMessage: nil, key: nil, message: nil, errors: nil)
                response(SRResponseResult.success(result: networkManagerResponse))
            case .failure(let err):
                response(SRResponseResult.failure(err))
            }
        }
    }
}
