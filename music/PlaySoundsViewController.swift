//
//  PlaySoundsViewController.swift
//  music
//
//  Created by Jon Castillo on 3/13/15.
//  Copyright (c) 2015 Jon Castillo. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func slowSpeed(sender: UIButton) {
        audioEngine.reset()
        audioPlayer.currentTime = 0
        audioPlayer.rate = 0.5
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }

    @IBAction func fastSpeed(sender: UIButton) {
        audioEngine.reset()
        audioPlayer.currentTime = 0
        audioPlayer.rate = 2.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
      playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopPlayback(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

}
