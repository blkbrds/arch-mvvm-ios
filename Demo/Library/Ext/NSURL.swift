//
//  NSURL.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/7/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

public enum HTTPStatus: Int {
    // Informational 1xx
    case `continue` = 100
    case switchingProtocols = 101
    case processing = 102
    case checkpoint = 103

    // Successful 2xx
    case success = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    case multiStatus = 207
    case alreadyReported = 208
    case imUsed = 226

    // Redirection 3xx
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case useProxy = 305
    case switchProxy = 306
    case temporaryRedirect = 307
    case resumeIncomplete = 308

    // Client Error 4xx
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case requestEntityTooLarge = 413
    case requestURITooLong = 414
    case unsupportedMediaType = 415
    case requestedRangeNotSatisfiable = 416
    case expectationFailed = 417
    case imATeapot = 418
    case authenticationTimeout = 419
    case enhanceYourCalm = 420
    case misdirectedRequest = 421
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431
    case loginTimeout = 440
    case noResponse = 444
    case retryWith = 449
    case blockedByWindowsParentalControls = 450
    case wrongExchangeServer = 451
    case requestHeaderTooLarge = 494
    case certError = 495
    case noCert = 496
    case httPtoHTTPS = 497
    case tokenExpiredOrInvalid = 498
    case cientClosedRequest = 499

    // Server Error 5xx
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505
    case variantAlsoNegotiates = 506
    case insufficientStorage = 507
    case loopDetected = 508
    case bandwidthLimitExceeded = 509
    case notExtended = 510
    case networkAuthenticationRequired = 511
    case networkReadTimeout = 598
    case networkConnectTimeout = 599

    public init?(code: Int) {
        self.init(rawValue: code)
    }

    public var code: Int {
        return rawValue
    }
}

extension HTTPStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .continue: // 100
            return "The server has received the request headers, and the client should proceed to send the request body."
        case .switchingProtocols: // 101
            return "The requester has asked the server to switch protocols."
        case .processing:
            return "Server has received and is processing the request."
        case .checkpoint: // 103
            return "Used in the resumable requests proposal to resume aborted PUT or POST requests."
        case .success: // 200
            return "The request is OK."
        case .created: // 201
            return "The request has been fulfilled, and a new resource is created ."
        case .accepted: // 202
            return "The request has been accepted for processing, but the processing has not been completed."
        case .nonAuthoritativeInformation: // 203
            return "The request has been successfully processed, but is returning information that may be from another source."
        case .noContent: // 204
            return "The request has been successfully processed, but is not returning any content."
        case .resetContent: // 205
            return "The request has been successfully processed, but is not returning any content, and requires that the requester reset the document view."
        case .partialContent: // 206
            return "The server is delivering only part of the resource due to a range header sent by the client."
        case .multiStatus: // 207
            return "XML, can contain multiple separate responses."
        case .alreadyReported: // 208
            return "Results previously returned."
        case .imUsed: // 226
            return "Request fulfilled, reponse is instance-manipulations."
        case .multipleChoices: // 300
            return "A link list. The user can select a link and go to that location. Maximum five addresses."
        case .movedPermanently: // 301
            return "The requested page has moved to a new URL."
        case .found: // 302
            return "The requested page has moved temporarily to a new URL."
        case .seeOther: // 303
            return "The requested page can be found under a different URL."
        case .notModified: // 304
            return "Indicates the requested page has not been modified since last requested."
        case .useProxy: // 305
            return "The requested resource must be accessed through the proxy given by the Location field."
        case .switchProxy: // 306
            return "No longer used."
        case .temporaryRedirect: // 307
            return "The requested page has moved temporarily to a new URL"
        case .resumeIncomplete: // 308
            return "Used in the resumable requests proposal to resume aborted PUT or POST requests."
        case .badRequest: // 400
            return "The request cannot be fulfilled due to bad syntax."
        case .unauthorized: // 401
            return "The request was a legal request, but the server is refusing to respond to it. For use when authentication is possible but has failed or not yet been provided."
        case .paymentRequired: // 402
            return "Reserved for future use."
        case .forbidden: // 403
            return "The request was a legal request, but the server is refusing to respond to it."
        case .notFound: // 404
            return "The requested page could not be found but may be available again in the future."
        case .methodNotAllowed: // 405
            return "A request was made of a page using a request method not supported by that page."
        case .notAcceptable: // 406
            return "The server can only generate a response that is not accepted by the client."
        case .proxyAuthenticationRequired: // 407
            return "The client must first authenticate itself with the proxy."
        case .requestTimeout: // 408
            return "The server timed out waiting for the request."
        case .conflict: // 409
            return "The request could not be completed because of a conflict in the request."
        case .gone: // 410
            return "The requested page is no longer available."
        case .lengthRequired: // 411
            return "The \"Content-Length\" is not defined. The server will not accept the request without it."
        case .preconditionFailed: // 412
            return "The precondition given in the request evaluated to false by the server."
        case .requestEntityTooLarge: // 413
            return "The server will not accept the request, because the request entity is too large."
        case .requestURITooLong: // 414
            return "The server will not accept the request, because the URL is too long. Occurs when you convert a POST request to a GET request with a long query information."
        case .unsupportedMediaType: // 415
            return "The server will not accept the request, because the media type is not supported."
        case .requestedRangeNotSatisfiable: // 416
            return "The client has asked for a portion of the file, but the server cannot supply that portion."
        case .expectationFailed: // 417
            return "The server cannot meet the requirements of the Expect request-header field."
        case .imATeapot: // 418
            return "I'm a teapot"
        case .authenticationTimeout: // 419
            return "Previously valid authentication has expired."
        case .enhanceYourCalm: // 420
            return "Twitter rate limiting."
        case .misdirectedRequest: // 421
            return "The request was directed at a server that is not able to produce a response."
        case .unprocessableEntity: // 422
            return "Request unable to be followed due to semantic errors."
        case .locked: // 423
            return "The resource that is being accessed is locked."
        case .failedDependency: // 424
            return "The request failed due to failure of a previous request."
        case .upgradeRequired: // 426
            return "The client should switch to a different protocol."
        case .preconditionRequired: // 428
            return "The origin server requires the request to be conditional."
        case .tooManyRequests: // 429
            return "The user has sent too many requests in a given amount of time."
        case .requestHeaderFieldsTooLarge: // 431
            return "Server is unwilling to process the request."
        case .loginTimeout: // 440
            return "Your session has expired."
        case .noResponse: // 444
            return "Server returns no information and closes the connection."
        case .retryWith: // 449
            return "Request should be retried after performing action."
        case .blockedByWindowsParentalControls: // 450
            return "Windows Parental Controls blocking access to webpage."
        case .wrongExchangeServer: // 451
            return "Resource access is denied for legal reasons."
        case .requestHeaderTooLarge: // 494
            return "Server is unwilling to process the request."
        case .certError: // 495
            return "SSL client certificate error occurred to distinguish it from 4XX in a log and an error page redirection."
        case .noCert: // 496
            return "Client didn't provide certificate to distinguish it from 4XX in a log and an error page redirection."
        case .httPtoHTTPS: // 497
            return "The plain HTTP requests are sent to HTTPS port to distinguish it from 4XX in a log and an error page redirection."
        case .tokenExpiredOrInvalid: // 498
            return "An expired or otherwise invalid token."
        case .cientClosedRequest: // 499
            return "Connection closed by client while HTTP server is processing."
        case .internalServerError: // 500
            return "A generic error message, given when no more specific message is suitable."
        case .notImplemented: // 501
            return "The server either does not recognize the request method, or it lacks the ability to fulfill the request."
        case .badGateway: // 502
            return "The server was acting as a gateway or proxy and received an invalid response from the upstream server."
        case .serviceUnavailable: // 503
            return "The server is currently unavailable (overloaded or down)."
        case .gatewayTimeout: // 504
            return "The server was acting as a gateway or proxy and did not receive a timely response from the upstream server."
        case .httpVersionNotSupported: // 505
            return "The server does not support the HTTP protocol version used in the request."
        case .variantAlsoNegotiates: // 506
            return "Transparent content negotiation for the request results in a circular reference."
        case .insufficientStorage: // 507
            return "The server is unable to store the representation needed to complete the request."
        case .loopDetected: // 508
            return "The server detected an infinite loop while processing the request."
        case .bandwidthLimitExceeded: // 509
            return "Server reached the bandwidth limit that the system administrator imposed."
        case .notExtended: // 510
            return "Further extensions to the request are required for the server to fulfil it."
        case .networkAuthenticationRequired: // 511
            return "The client needs to authenticate to gain network access."
        case .networkReadTimeout: // 598
            return "Network read timeout behind the proxy."
        case .networkConnectTimeout: // 599
            return "Network connect timeout behind the proxy."
        }
    }
}

extension NSError {
    public convenience init(domain: String? = nil, status: HTTPStatus, message: String? = nil) {
        let domain = domain ?? Bundle.main.bundleIdentifier ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: message ?? status.description]
        self.init(domain: domain, code: status.code, userInfo: userInfo)
    }

    public convenience init(domain: String? = nil, code: Int = -999, message: String) {
        let domain = domain ?? Bundle.main.bundleIdentifier ?? ""
        let userInfo: [String: String] = [NSLocalizedDescriptionKey: message]
        self.init(domain: domain, code: code, userInfo: userInfo)
    }
}

extension URL {
    public var imageRequest: NSMutableURLRequest {
        let request = NSMutableURLRequest(url: self)
        request.addValue("image/*", forHTTPHeaderField: "Accept")
        return request
    }
}
