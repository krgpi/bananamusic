//
//  ContentViewController.swift
//  bananamusic
//
//  Created by Yuki NOAKI on 2019/06/12.
//  Copyright © 2019 Yuki NOAKI. All rights reserved.
//

import UIKit
import MediaPlayer


class contentViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    //Creates a global instance of the system music player
    var myMediaPlayer = MPMusicPlayerController.systemMusicPlayer
    
    func chooseSongsButtonPressed() {
        let myMediaPickerVC = MPMediaPickerController(mediaTypes: MPMediaType.music)
        myMediaPickerVC.allowsPickingMultipleItems = true
//        myMediaPickerVC.popoverPresentationController?.sourceView = myMediaPickerVC.popoverPresentationController?.presentedView
        myMediaPickerVC.delegate = self
        self.present(myMediaPickerVC, animated: true, completion: nil)
    }
    
}
