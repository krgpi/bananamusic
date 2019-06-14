//
//  ContentView.swift
//  bananamusic
//
//  Created by Yuki NOAKI on 2019/06/04.
//  Copyright © 2019 Yuki NOAKI. All rights reserved.
//

import Foundation
import SwiftUI
import MediaPlayer
import UIKit

let myNetwork = musicNetwork()
let myMediaPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
let genURL = { (str: String) -> UIImage in
    var image: UIImage = UIImage.init()
    do{
        guard let url = URL(string: str) else {
            print("Err: parse string to url: \(str)")
            return UIImage()
        }
        var data = try Data(contentsOf: url)
        guard let image = UIImage(data: data) else {
            print("Err: convert data to UIImage")
            return UIImage()}
    }catch{
        print("err")
    }
    return image
}


@available(iOS 13.0, *)
struct ContentView : View {
    var currentNextSongList: Song
    var rad: CGFloat = CGFloat(10)
    var body: some View {
        VStack{
            Spacer()
            NavigationView {
                NavigationButton(destination: musicSelectView(currentNextSongList.data.map {hogeView($0)})){
                    Text("MUSIC")
                }
            }
            HStack{
                Spacer()
                Button(action: {}) {
                    rewindButton()
                }.shadow(radius: rad)
                    .tapAction {
                        <#code#>
                }
                Spacer()
                Button(action: {myMediaPlayer.play()}) {
                    playButton()
                }.shadow(radius: rad)
                Spacer()
                Button(action: {}) {
                    forwardButton()
                }.shadow(radius: rad)
                Spacer()
            }.padding()
            HStack{
                nextList(nextSongList: currentNextSongList)
            }.padding()
        }
    }
}

// Notice that the generic initializer takes an array of views, and nests each one in a UIHostingController.
// A UIHostingController is a UIViewController subclass that represents a SwiftUI view within UIKit contexts.
struct musicSelectView<Content: View>: View{
    var vc: [UIHostingController<Content>]
    init(_ views: [Content]){
        self.vc = views.map { UIHostingController(rootView: $0)}
    }
    var body: some View{
        musicSelectUIViewController(controllers: vc)
    }
}

@available(iOS 13.0, *)
struct nextList: View{
    var nextSongList: Song
    var body: some View {
        NavigationView{
            List(nextSongList.data.identified(by: \.id)) { songObject in
                nextListRow(nextSong: songObject)
            }.navigationBarTitle(Text("Next"))
        }
    }
}

struct nextListRow: View {
    var nextSong: Song.songData
    var body: some View {
        HStack{
            Image(uiImage: genURL(nextSong.attributes.artwork.url))
            Text(nextSong.attributes.name)
        }
    }
}

@available(iOS 13.0, *)
struct playButton: View {
    var body: some View {
        GeometryReader {geometry in
            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                let startX: CGFloat = width / 2 - width / 3
                let startY: CGFloat = 0
                path.move(to: CGPoint(x:startX,y:startY))
                path.addLine(to: .init(x:startX + 0, y:startY + width))
                path.addLine(to: .init(x:startX + width, y:startY + width/2))
                path.addLine(to: .init(x:startX, y:startY))
            }.fill(Color.black)
             }
    }
}

@available(iOS 13.0, *)
struct forwardButton: View {
    let startX: CGFloat = 0
    let startY: CGFloat = 0
    var body: some View {
        GeometryReader {geometory in
            Path { path in
                let width = min(geometory.size.width, geometory.size.height)
                
                path.move(to: CGPoint(x:self.startX,y:self.startY))
                path.addLine(to: .init(x: self.startX + 0, y: self.startY + width))
                path.addLine(to: .init(x:self.startX + width/2, y:self.startY + width/2))
                path.addLine(to: .init(x:self.startX, y:self.startY))
                
                path.move(to: CGPoint(x:self.startX + width/2,y:self.startY))
                path.addLine(to: .init(x: self.startX + width/2 + 0, y: self.startY + width))
                path.addLine(to: .init(x:self.startX + width, y:self.startY+width/2))
                path.addLine(to: .init(x:self.startX + width/2, y:self.startY))

                }.fill(Color.black)
        }
    }
    
}

@available(iOS 13.0, *)
struct rewindButton: View{
    let startX: CGFloat = 0
    let startY: CGFloat = 0
    var body: some View {
        GeometryReader { geometory in
            Path { path in
                let width = min(geometory.size.width, geometory.size.height)
                
                path.move(to: CGPoint(x:self.startX,y:self.startY))
                path.addLines([
                    CGPoint(x: self.startX + width, y: self.startY),
                    CGPoint(x: self.startX + width, y: self.startY + width),
                    CGPoint(x: self.startX + width/2, y: self.startY + width/2),
                    CGPoint(x: self.startX + width, y: self.startY)
                    ])
                    
                path.addLines([
                    CGPoint(x: self.startX + width/2, y: self.startY),
                    CGPoint(x: self.startX + width/2, y: self.startY + width),
                    CGPoint(x: self.startX, y: self.startY + width/2),
                    CGPoint(x: self.startX + width/2, y: self.startY)
                    ])
            }.fill(Color.black)
        }
    }
}

#if DEBUG
@available(iOS 13.0, *)
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(currentNextSongList: myNetwork.getNextItem(id: "1"), rad: CGFloat(10))
    }
}
#endif
