//
//  Album.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 09.02.2021.
//

struct Albums: Decodable {
    let resultCount: Int
    let results: [Album]
}

struct Album: Decodable {
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let trackCount: Int
    let releaseDate: String
}
