//
//  network.swift
//  bananamusic
//
//  Created by Yuki NOAKI on 2019/06/10.
//  Copyright © 2019 Yuki NOAKI. All rights reserved.
//

import Foundation
import RealmSwift

//DBに格納する曲＋情報
class songItem: Object {
    
    dynamic var id: String = "0"
    dynamic var nextList: [String: Int64] = [:]
//    var nextSong = List<songItem>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}



