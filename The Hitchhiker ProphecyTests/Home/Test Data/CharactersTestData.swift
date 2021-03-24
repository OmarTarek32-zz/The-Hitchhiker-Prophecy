//
//  CharactersTestData.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Omar Tarek on 3/24/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy

struct CharactersTestData {
    
    static func createComics() -> Characters.Search.Character.Comics {
        let comicsItems = [
            Characters.Search.Character.Comics.ComicsItem(resourceURI: "https://com.mvl/FDF43",
                                                                         name: "ComicsItemName1"),
            Characters.Search.Character.Comics.ComicsItem(resourceURI: "https://com.mvl/434FDFS",
                                                                             name: "ComicsItemName2")
        ]
        
        let comics = Characters.Search.Character.Comics(available: 50,
                                                        collectionURI: "https://com.mvl/id3",
                                                        items: comicsItems ,
                                                        returned: 20)
        return comics
    }
    
    static func createSeries() -> Characters.Search.Character.Comics {
        let seriesItems = [
            Characters.Search.Character.Comics.ComicsItem(resourceURI: "https://com.mvl/SFDF3",
                                                                         name: "SeriesItemsName1"),
            Characters.Search.Character.Comics.ComicsItem(resourceURI: "https://com.mvl/GFJ54G",
                                                                             name: "SeriesItemsName2")
        ]
        
        let series = Characters.Search.Character.Comics(available: 50,
                                                        collectionURI: "https://com.mvl/F43fD",
                                                        items: seriesItems ,
                                                        returned: 20)
        return series
    }
    
    static func createEvents() -> Characters.Search.Character.Comics {
        let eventsItems = [
            Characters.Search.Character.Comics.ComicsItem(resourceURI: "https://com.mvl/DFG76G",
                                                                         name: "EventsItemsName1"),
            Characters.Search.Character.Comics.ComicsItem(resourceURI: "https://com.mvl/KBN4Y",
                                                                             name: "EventsItemsName2")
        ]
        
        let events = Characters.Search.Character.Comics(available: 50,
                                                        collectionURI: "https://com.mvl/XDV75",
                                                        items: eventsItems,
                                                        returned: 20)
        return events
    }
    
    static func createStories() -> Characters.Search.Character.Stories {
        let storiesItems = [
            Characters.Search.Character.Stories.StoriesItem(resourceURI: "https://com.mvl/KBN4Y",
                                                            name: "StoriesItemsName1",
                                                            type: "StoriesItemsType1"),
            Characters.Search.Character.Stories.StoriesItem(resourceURI: "https://com.mvl/XVJ34",
                                                            name: "StoriesItemsName2",
                                                            type: "StoriesItemsType2")
        ]
        
        let stories = Characters.Search.Character.Stories(available: 50,
                                                          collectionURI: "https://com.mvl/FDB34",
                                                          items: storiesItems,
                                                          returned: 20)
        
        return stories
    }
    
    static func createCharactersURLElement() -> [Characters.Search.Character.URLElement] {
        return [
            Characters.Search.Character.URLElement(type: Characters.Search.Character.URLElement.URLType.wiki,
                                                   url: "https://com.mvl/CBG2S"),
            Characters.Search.Character.URLElement(type: Characters.Search.Character.URLElement.URLType.detail,
                                                           url: "https://com.mvl/KJB45G")]
    }
    
    static func createThumbnail() -> Characters.Search.Character.Thumbnail {
        Characters.Search.Character.Thumbnail(path: "https://www.photos.marvel/characters/ironman/23434",
                                                              thumbnailExtension: "png")
    }
    
    
    static func createCharacter() -> Characters.Search.Character {
        
        let thumbnail = createThumbnail()
        let comics = createComics()
        let series = createSeries()
        let events = createEvents()
        let stories = createStories()
        let urls = createCharactersURLElement()
        
        let character = Characters.Search.Character(id: 1,
                                                    name: "Iron Man",
                                                    resultDescription: "Iron Man Description",
                                                    modified: "Today",
                                                    thumbnail: thumbnail,
                                                    resourceURI: "https://www.photos.marvel/characters/ironman/23434",
                                                    comics: comics,
                                                    series: series,
                                                    stories: stories,
                                                    events: events,
                                                    urls: urls)
        
        return character
    }

}
