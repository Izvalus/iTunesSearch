//
//  NetworkProvider.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 10.02.2021.
//

import Foundation

final class NetworkProvider {
    
    private let albumURL = "https://itunes.apple.com/search?"
    private let songURL = "https://itunes.apple.com/lookup?entity=song&id="
    
    let networkClient = NetworkClient()
    
    func fetchData(album: String, completion: @escaping(Result<Albums, Error>) -> Void) {
        networkClient.request(
            endPoint: "search",
            parameters: ["entity": "album", "term": album],
            completion: completion
        )
    }
    func fetchSongs(albumID: String, completion: @escaping(Result<Songs, Error>) -> Void) {
        networkClient.request(
            endPoint: "lookup",
            parameters: ["entity": "song", "id": albumID],
            completion: completion
        )
    }
}
