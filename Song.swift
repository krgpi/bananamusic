//
//  Song.swift
//  bananamusic
//
//  Created by Yuki NOAKI on 2019/06/13.
//  Copyright © 2019 Yuki NOAKI. All rights reserved.
//

struct Song: Codable {
    let data: [songData]
    struct songData: Codable {
        let attributes: Attributes
        struct Attributes: Codable {
            let albumName: String
            let artistName: String
            let artwork: Artwork
            struct Artwork: Codable {
                let bgColor: String
                let height: Int
                let textColor1: String
                let textColor2: String
                let textColor3: String
                let textColor4: String
                let url: String
                let width: Int
            }
            let composerName: String
            let discNumber: Int
            let durationInMillis: Int
            let genreNames: [String]
            let isrc: String
            let name: String
            let playParams: PlayParams
            struct PlayParams: Codable{
                let id: String
                let kind: String
            }
            let previews: [Previews]
            struct Previews: Codable{
                let url: String
            }
            let releaseDate: String
            let trackNumber: Int
            let url: String
        }
        let href: String
        let id: String
        let relationships: Relationships
        struct Relationships: Codable{
            let albums: Albums
            struct Albums: Codable {
                let data: [albumsData]
                struct albumsData: Codable {
                    let href: String
                    let id: String
                    let type: String
                }
                let href: String
            }
            let artists: Artists
            struct Artists: Codable{
                let data: [artistsData]
                struct artistsData: Codable{
                    let href: String
                    let id: String
                    let type: String
                }
                let href: String
            }
        }
        let type: String
    }
}
