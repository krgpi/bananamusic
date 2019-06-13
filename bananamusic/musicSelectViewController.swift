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

struct musicSelectViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    func makeUIViewController(context: Context) -> MPMediaPickerController{
        let myMediaPickerVC = MPMediaPickerController(mediaTypes: MPMediaType.music)
        myMediaPickerVC.allowsPickingMultipleItems = true
//        myMediaPickerVC.popoverPresentationController?.sourceView = sender
//        myMediaPickerVC.delegate = MPMediaPickerControllerDelegate
//        self.present(myMediaPickerVC, animated: true, completion: nil)
        return myMediaPickerVC
    }
    func updateUIViewController(_ uiViewController: MPMediaPickerController, context: Context) {
        
    }
}

class musicSelectViewControllerClass: UIViewController, MPMediaPickerControllerDelegate {
    
    //Creates a global instance of the system music player
    var myMediaPlayer = MPMusicPlayerController.systemMusicPlayer

}
