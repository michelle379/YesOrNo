//
//  EndViewController.swift
//  YesOrNo
//
//  Created by 王宜婕 on 2024/10/20.
//

import UIKit
import AVFoundation

class EndViewController: UIViewController {
    let player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "winsound", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        // Do any additional setup after loading the view.
    }




}
#Preview{
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //withIdentifier內打入View名稱
    return storyboard.instantiateViewController(withIdentifier: "EndViewController")
}

