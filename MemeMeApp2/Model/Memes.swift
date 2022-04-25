//
//  Memes.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/25/22.
//

import Foundation

private var globalId = 0

struct MemeListEntry {
    
    let id: Int
    let meme: Meme
    
    init(_ meme: Meme) {
        globalId += 1
        
        id = globalId
        self.meme = meme
    }
}
struct Memes {
    
    static let shared = Memes()
    
    private var memes: [MemeListEntry] = []
    private static var singleton: Memes?
    
    mutating func append(_ meme: Meme) {
        memes.append(MemeListEntry( meme))
    }
    
    func getMemes() -> [MemeListEntry] {
        return memes
    }
    
    mutating func removeMeme(entry: MemeListEntry) {
        memes = memes.filter({ e in
            e.id != entry.id
        })
    }
    
    private init() {
        
    }
}
