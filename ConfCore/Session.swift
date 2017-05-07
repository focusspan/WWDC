//
//  Session.swift
//  WWDC
//
//  Created by Guilherme Rambo on 06/02/17.
//  Copyright © 2017 Guilherme Rambo. All rights reserved.
//

import Cocoa
import RealmSwift

/// Specifies a session in an event, with its related keywords, assets, instances, user favorites and user bookmarks
public class Session: Object {

    /// Unique identifier
    public dynamic var identifier = ""
    
    /// Session number
    public dynamic var number = ""
    
    /// Title
    public dynamic var title = ""
    
    /// Description
    public dynamic var summary = ""
    
    /// Event identifier (only using during JSON adapting)
    public dynamic var eventIdentifier = ""
    
    /// Track name (only using during JSON adapting)
    public dynamic var trackName = ""
    
    /// The session's focuses
    public let focuses = List<Focus>()
    
    /// The session's assets (videos, slides, links)
    public let assets = List<SessionAsset>()
    
    /// Session favorite
    public let favorites = List<Favorite>()
    
    /// Session bookmarks
    public let bookmarks = List<Bookmark>()
    
    /// Transcript for the session
    public dynamic var transcript: Transcript?
    
    /// The session's track
    public let track = LinkingObjects(fromType: Track.self, property: "sessions")
    
    /// The event this session belongs to
    public let event = LinkingObjects(fromType: Event.self, property: "sessions")
    
    /// Instances of this session
    public let instances = LinkingObjects(fromType: SessionInstance.self, property: "session")
    
    public override static func primaryKey() -> String? {
        return "identifier"
    }
    
    public override static func ignoredProperties() -> [String] {
        return ["trackName", "eventIdentifier"]
    }
    
    public static func standardSort(sessionA: Session, sessionB: Session) -> Bool {
        guard let eventA = sessionA.event.first, let eventB = sessionB.event.first else { return false }
        guard let trackA = sessionA.track.first, let trackB = sessionB.track.first else { return false }
        
        if trackA.order == trackB.order {
            if eventA.startDate == eventB.startDate {
                return sessionA.title < sessionB.title
            } else {
                return eventA.startDate > eventB.startDate
            }
        } else {
            return trackA.order < trackB.order
        }
    }
    
}