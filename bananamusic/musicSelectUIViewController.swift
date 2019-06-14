//
//  musicSelectView.swift
//  bananamusic
//
//  Created by Yuki NOAKI on 2019/06/12.
//  Copyright © 2019 Yuki NOAKI. All rights reserved.
//

//import Foundation
import MediaPlayer
import SwiftUI

struct musicSelectUIViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<musicSelectUIViewController>) -> musicSelectViewControllerClass {
        let vc = musicSelectViewControllerClass()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: musicSelectViewControllerClass, context: Context) {
        
    }
    
    class Coordinator: NSObject {
        var parent: musicSelectUIViewController
        init(_ vc: musicSelectUIViewController){
            self.parent = vc
        }
    }
}

class musicSelectViewControllerClass: UIViewController, MPMediaPickerControllerDelegate {
    
    //Creates a global instance of the system music player
    var myMediaPlayer = MPMusicPlayerController.systemMusicPlayer
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        print(mediaItemCollection[0].debugDescription)
    }
    
    func chooseSongsButtonPressed(_ sender: UIButton) {
        let myMediaPickerVC = MPMediaPickerController(mediaTypes: MPMediaType.music)
        myMediaPickerVC.allowsPickingMultipleItems = true
        myMediaPickerVC.popoverPresentationController?.sourceView = sender
        myMediaPickerVC.delegate = self
        self.present(myMediaPickerVC, animated: true, completion: nil)
    }

}
