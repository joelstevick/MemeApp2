//
//  Memes.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/25/22.
//
// This service (singleton) is used to manage the shared data needed for the app
// Developer note: I have a personal preference for using explicit get-functions rather than getters.

import Foundation

private var globalId = 0

struct MemeListEntry {
    
    let id: Int
    var meme: Meme
    
    init(_ meme: Meme) {
        globalId += 1
        
        id = globalId
        self.meme = meme
    }
}
class Memes {
    
    static let shared = Memes()
    
    private var memes: [MemeListEntry] = []
    private static var singleton: Memes?
    
    func append(_ meme: Meme) {
        memes.append(MemeListEntry( meme))
    }
    
    func replace(entryId: Int, meme: Meme) {
        
        let entry = memes.first { entry in
            entry.id == entryId
        }
        
        if var entry = entry {
            entry.meme = meme
        }
    
    }
    
    func getMemes() -> [MemeListEntry] {
        return memes
    }
    
    func removeMeme(entry: MemeListEntry) {
        memes = memes.filter({ e in
            e.id != entry.id
        })
    }
    
    private init() {
        
    }
}
