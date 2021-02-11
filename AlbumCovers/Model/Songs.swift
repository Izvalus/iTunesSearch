//
//  Songs.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 11.02.2021.
//

struct Songs: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let trackCount: Int?
    let trackName: String?
}
