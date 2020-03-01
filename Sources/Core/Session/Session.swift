//
//  Session.swift
//  
//
//  Created by Alexander Filimonov on 01/03/2020.
//

import Foundation
import Rainbow

public final class Session {

    // MARK: - Nested Types

    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }

    // MARK: - Private Properties

    private let tokenProvider: TokenProvider?

    // MARK: - Initializaion

    /// Base initialization
    /// - Parameter tokenProvider: token provider for authorization if needed
    public init(tokenProvider: TokenProvider? = nil) {
        self.tokenProvider = tokenProvider
    }

    // MARK: - Methods

    /// Method for performing network request (returns decodable obj)
    /// - Parameters:
    ///   - urlString: urlString address
    ///   - method: method for request
    ///   - params: dict with parameters
    public func performRequest<T: Decodable>(urlString: String,
                                             method: Method,
                                             params: [String: String] = [:]) throws -> T {
        guard var urlComponents = URLComponents(string: urlString) else {
            throw SessionError.couldntCreateUrl
        }

        var request = URLRequest(url: urlComponents.url!)
        if let tokenUnwrapped = try? tokenProvider?.getToken() {
            request.setValue("\(tokenUnwrapped.tokenType) \(tokenUnwrapped.accessToken)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = method.rawValue

        // add params for get
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        for (key, value) in params {
          queryItems.append(URLQueryItem(name: key, value: value))
        }
        if method == .get {
          urlComponents.queryItems = queryItems
        }

        // add params for post
        if method == .post || method == .put {
          request.httpBody = try? JSONEncoder().encode(params)
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        var responseObj: T?
        var currentError: SessionError?

        let sm = DispatchSemaphore(value: 0)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            if let dataUnwrapped = data {
                let jsonDecoder = JSONDecoder()
                responseObj = try? jsonDecoder.decode(T.self, from: dataUnwrapped)
                if responseObj == nil {
                    currentError = SessionError.couldntParse
                }
            }
            sm.signal()
        }
        task.resume()
        _ = sm.wait(timeout: .distantFuture)

        if let errorUnwrapped = currentError {
            throw errorUnwrapped
        }
        guard let responseObjUnwrapped = responseObj else {
            throw SessionError.networkError
        }
        return responseObjUnwrapped
    }

}
