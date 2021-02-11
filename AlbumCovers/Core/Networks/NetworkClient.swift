//
//  NetworkClient.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 11.02.2021.
//

import Foundation

final class NetworkClient {
    
    enum NetworkError: Error {
        case noDataAvilable
        case canNotProcessData
    }
    
    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    
    private let baseURL = "https://itunes.apple.com/"
    
    func request<ResponsModel>(
        endPoint: String,
        parameters: [String: String],
        method: String = "GET",
        completion: @escaping(Result<ResponsModel, Error>) -> Void
    ) where ResponsModel: Decodable {
        guard var components = URLComponents(string: baseURL + endPoint) else { return }
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        guard let requestURL = components.url else { return }
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = method
        session.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            guard let jsonData = data else {
                completion(.failure(NetworkError.noDataAvilable))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(ResponsModel.self, from: jsonData)
                completion(.success(decodedData))
            } catch {
                print(error)
                completion(.failure(NetworkError.canNotProcessData))
            }
        }.resume()
    }
}
