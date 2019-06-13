//
//  musicDeal.swift
//  bananamusic
//
//  Created by Yuki NOAKI on 2019/06/11.
//  Copyright © 2019 Yuki NOAKI. All rights reserved.
//

import Foundation
import RealmSwift

class musicNetwork: Object {
    
    let realmInstance = try! Realm()
    
    //初めて再生された曲＝DBにidが存在しない曲→DBに新規追加
    func addItem(id: String){
        let newSong = songItem(value: ["id": id])
            try! realmInstance.write{
                realmInstance.add(newSong)
        }
    }
    
    //すでに存在する曲
    func updateList(id: String, addid: String){
        let selectItems = realmInstance.objects(songItem.self).filter("id = " + id)
        switch selectItems.count {
            case 0: //該当なし→新規作成
                let newSong = songItem(value: ["id": id, "nextList": [addid:1]])
                try! realmInstance.write{
                    realmInstance.add(newSong)
                }
            case 1: //該当あり→加算
                selectItems.first?.nextList[addid]! += 1
            default:
                print("Err: musicNetwork.swift - func updateList() - case default")
                return
            }
    }
    
    func getNextItem(id: String)->[Data]{
        let selectItems = realmInstance.objects(songItem.self).filter("id = " + id)
        var nextItemArray: [Data] = []
        switch selectItems.count {
            case 0: //該当なし→新規作成
                print("noItem")
            case 1: //該当あり→加算
                let list = selectItems.first!.nextList
                for row in list{
                    let id: String = row.key
                    getSong(id, after: {
                        json in
                            print(json)
                        nextItemArray.append(json as! Data)
                        //Songオブジェクト的なものにマッピングして、そのオブジェクトの配列を返す
                    })
                }
            default:
                print("Err: musicNetwork.swift - func updateList() - case default")
            }
        
        
        return nextItemArray
    }
    
    func getSong(_ id: String, after:@escaping (Any)->()){
        var components = URLComponents(string: "https://api.music.apple.com/v1/catalog/ja/songs?")
        components?.queryItems = [URLQueryItem(name: "ids", value: id)]
        let url = components?.url
        let task = URLSession.shared.dataTask(with: url!){
            data,response,error in
            if let data = data, let response = response {
                print(response)
                let decoder: JSONDecoder = JSONDecoder()
                do{
                    let json: Song = try decoder.decode(Song.self, from: data)
                    after(json)
                    
                }catch{
                    print("Serivalize Error")
                }
            }else{
                print(error ?? "Error")
            }
        }
        task.resume()
    }
}
