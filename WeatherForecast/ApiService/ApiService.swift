//
//  ApiService.swift
//  WeatherForecast
//
//  Created by httruc on 27/02/2021.
//

import Foundation

final class ApiService: NSObject {
    private let host: String
    
    init(host: String) {
        self.host = host
    }
    
    private lazy var session: URLSession = URLSession(
        configuration: .default,
        delegate: self,
        delegateQueue: .main
    )
    
    private func createRequest(from httpRequest: HTTPRequest) throws -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = httpRequest.path
        urlComponents.queryItems = httpRequest.params?.map(URLQueryItem.init)
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = httpRequest.httpMethod.rawValue
        if let body = httpRequest.body {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(body)
        }
        return urlRequest
    }
    
    private func execute(
        request: HTTPRequest,
        completion: @escaping (Result<Data, BaseError>) -> Void) {
        guard let urlRequest = try? createRequest(from: request) else {
            completion(.failure(.badRequest))
            return
        }
        Logger.log("*** Request: " + (urlRequest.url?.absoluteString ?? ""))
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            Logger.log("*** Response: " + (urlRequest.url?.absoluteString ?? ""))
            guard let data = data else {
                completion(.failure(.network))
                return
            }
            Logger.log(data.jsonString())
            completion(.success(data))
        }
        .resume()
    }
    
    func fetch<ResponseType: Decodable>(
        request: HTTPRequest,
        completion: @escaping (Result<ResponseType, BaseError>) -> Void) {
        
        execute(request: request) { result in
            let result = result.flatMap { (data) -> Result<ResponseType, BaseError> in
                do {
                    let response = try JSONDecoder().decode(ResponseType.self, from: data)
                    return .success(response)
                } catch {
                    return .failure(.parseJson(error))
                }
            }
            completion(result)
        }
    }
}

extension ApiService: URLSessionDelegate {
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
