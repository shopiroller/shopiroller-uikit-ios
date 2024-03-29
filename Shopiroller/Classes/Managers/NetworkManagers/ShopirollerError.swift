//
//  ShopirollerError.swift
//  shopiroller
//
//  Created by Görkem Gür on 16.09.2021.
//


import Foundation
import Sentry

public enum ShopirollerError: Error, Equatable {
    case network, url, parseObject, parseJSON, general, encode, createJSON, download, expiredToken, checkUidUserExists(userMessage: String)
    case validation(description: String)
    case other(title: String?, description: String, isUserFriendlyMessage: Bool? = nil,key: String? = nil)
    
    public var description: String {
        switch self {
        case .network:
            return NSLocalizedString("Network Error".localized, comment: "network_error")
        case .parseObject:
            return NSLocalizedString("Parse Object Error", comment: "parse_object_error")
        case .parseJSON:
            return NSLocalizedString("Parse JSON Error", comment: "parse_json_error")
        case .url:
            return NSLocalizedString("Url Error", comment: "url_error")
        case .download:
            return NSLocalizedString("Download Error", comment: "download_error")
        case .createJSON:
            return NSLocalizedString("Create JSON Error", comment: "create_json_error")
        case .expiredToken:
            return NSLocalizedString("Oturum Süresi Dolmuştur.", comment: "auth_error")
        case .checkUidUserExists(let userMessage):
            return userMessage
        case .other(_, let description, _ , _):
            return description
        case .validation(let description):
            return description
        default:
            return "Error"
        }
    }
    
    public var localizedDescription: String {
        return description
    }
    
    public var errorMessageKey: String {
        switch self {
        case .other(_,_,_, let key):
            return key ?? ""
        default:
            return ""
        }
    }
    
    public var isUserFriendlyMessage: Bool? {
        switch self {
        case .other(_,_,let isUserFriendlyMessage,_):
            return isUserFriendlyMessage
        default:
            return false
        }
    }
    
    public var title: String {
        switch self {
        case .other(_,let title,_,_):
            return title ?? "generic-error-title"
        default:
            return "generic-error-title"
        }
    }
    
    public var isValidationError: Bool {
        switch self {
        case .validation(_):
            return true
        default:
            return false
        }
    }
    
    public static func ==(left: ShopirollerError, right: ShopirollerError) -> Bool {
        switch (left, right) {
        case (.network, .network),
             (.parseJSON, .parseJSON),
             (.parseObject, .parseObject),
             (.createJSON, .createJSON),
             (.encode, .encode),
             (.url, .url),
             (.checkUidUserExists(_), checkUidUserExists(_)),
            (.expiredToken, .expiredToken):
            return true
            
        case (.other(let leftTitle, let leftDescription , let leftIsUserFriendlyMessage, let leftKey), .other(let rightTitle, let rightDescription, let rightIsUserFriendlyMessage,let rightKey)):
            return leftDescription == rightDescription && leftIsUserFriendlyMessage == rightIsUserFriendlyMessage && leftTitle == rightTitle && leftKey == rightKey
        default:
            return false
        }
    }
}


extension Error {
    
    var isConnectivityError: Bool {
        // let code = self._code || Can safely bridged to NSError, avoid using _ members
        let code = (self as NSError).code
        
        if (code == NSURLErrorTimedOut) {
            return true // time-out
        }
        
        if (self._domain != NSURLErrorDomain) {
            return false // Cannot be a NSURLConnection error
        }
        
        switch (code) {
        case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost, NSURLErrorCannotConnectToHost:
            return true
        default:
            return false
        }
    }
    
    var convertError: ShopirollerError {
        guard let error = self as? DecodingError else {
            return ShopirollerError.parseJSON
        }
        var errorMessage: String = ""
        switch error {
        case DecodingError.dataCorrupted(let context):
            errorMessage = context.debugDescription
        case DecodingError.keyNotFound(let key, let context):
            errorMessage = "\(key.stringValue) was not found, \(context.debugDescription)\ncontext: \(context.codingPath)"
        case DecodingError.typeMismatch(let type, let context):
            errorMessage = "\(type) was expected, \(context.debugDescription)\ncontext: \(context.codingPath)"
        case DecodingError.valueNotFound(let type, let context):
            errorMessage = "no value was found for \(type), \(context.debugDescription)\ncontext\(context.codingPath)"
        default:
            if let decodeError = self as? DecodingError {
                errorMessage = decodeError.localizedDescription
            }
            break
        }
        SentrySDK.capture(message: "Error: \(error) \n" + "Error Message: \(errorMessage)")
        #if DEBUG
//        loggingPrint(errorMessage)
        return ShopirollerError.other(title: "", description: errorMessage)
        #else
//        errorMessage = "Lütfen kısa bir süre sonra tekrar deneyiniz."
        return ShopirollerError.parseJSON
        #endif
    }
}
