//
//  Anime.swift
//  Twister
//
//  Created by Thoralf Thelle on 29/06/2019.
//  Copyright © 2019 twist. All rights reserved.
//

// Coming from JS, Swift has a bit more of a complex way to do fetching of web content.

import Foundation

// Structs for the JSON task
// AnimeFeed: Struct based on the RSS feed of /feed/anime
struct AnimeFeed:Codable {
    let items:[AnimeItem]
}
// EpisodeFeed: Struct based on the RSS feed of /feed/episodes
struct EpisodeFeed:Codable {
    let items:[EpisodeItem]
}
// EpisodeItem: Array struct of the items in EpisodeFeed
struct EpisodeItem: Codable {
    let title, itemDescription: String
    let link: String
    let guid: GUID
    let pubdate, animeTitle: String
    let episodeNumber, animetwistID, kitsuID: Int
    let malID: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case title
        case itemDescription = "description"
        case link, guid, pubdate
        case animeTitle = "anime:title"
        case episodeNumber = "episode:number"
        case animetwistID = "animetwist:id"
        case kitsuID = "kitsu:id"
        case malID = "mal:id"
    }
}
// AnimeItem: Array struct of the items in AnimeFeed
struct AnimeItem:Codable {
    let title, itemDescription: String
    let link: String
    let guid: GUID
    let pubdate, animeTitle: String
    let animeOngoing: Int
    let animetwistSlug: String
    let animetwistID, kitsuID, malID: Int? // Nall, why? :(
    
    enum CodingKeys: String, CodingKey {
        case title
        case itemDescription = "description"
        case link, guid, pubdate
        case animeTitle = "anime:title"
        case animeOngoing = "anime:ongoing"
        case animetwistSlug = "animetwist:slug"
        case animetwistID = "animetwist:id"
        case kitsuID = "kitsu:id"
        case malID = "mal:id"
    }
}
// GUID: Struct for the GUID object
struct GUID: Codable {
    let ispermalink: String
    let text: String
}

// Classes
// AnimeFeedFetch: Executes fetching of animes/episodes
public class AnimeFeedFetch
{
    
    let FeedURL = "https://twist.moe/feed/anime?format=json"
    let EpURL = "https://twist.moe/feed/episodes?format=json&kitsuId="
    
    // getAll(): gets all the animes from the rss feed
    func getAll(completionHandler: @escaping (_ items: Array<AnimeItem>) -> ())
    {
        if let URL = URL(string: FeedURL)
        {
            URLSession.shared.dataTask(with: URL) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(AnimeFeed.self, from: data)
                        
                        completionHandler(res.items)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    // get(): gets the episodes of the selected anime feed based on the kitsu ID.
    func get(kitsuID: Int)
    {
        if let URL = URL(string: EpURL + String(kitsuID))
        {
            URLSession.shared.dataTask(with: URL) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(AnimeFeed.self, from: data)
                        
                        print(res.items)
                    } catch let error {
                        print(error)
                    }
                }
                }.resume()
        }
    }
}

// JSONNull: Optional handling of a possible null element in JSON
class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
