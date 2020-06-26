//
//  ViewController.swift
//  MyMetronome
//
//  Created by Penny Huang on 2020/5/31.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UIPopoverPresentationControllerDelegate, TimeSigVCDelegate, TempoMarkingDelegate {
    
    var player = AVPlayer()
    var playerItem: AVPlayerItem!
    var timeObserverToken: Any?

    var beatTimer = Timer()
    var timeTimer = Timer()
    
    var startPanlocation: CGPoint!
    
    @IBOutlet weak var timeSigButtonOutlet: UIButton!
    
    @IBOutlet weak var bpmLabelOutlet: UILabel!
    
    @IBOutlet weak var tempoMarkingButtonOutlet: UIButton!
    
    @IBOutlet weak var minusButtonOutlet: UIButton!
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    @IBOutlet weak var playButtonOutlet: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet var beatImageOutlets: [UIImageView]!
    
    @IBOutlet weak var soundOnButtonOutlet: UIButton!
    
    // MARK: Non-funcational UI Outlets
    @IBOutlet weak var beatBarOutlet: UIView!
    
    
    
    
    // MARK: - BPM
    @IBAction func minusButtonPressed(_ sender: Any) {
        minusBPMValue()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        addBPMValue()
    }
    
    // MARK: Gesture
    @IBAction func minusLongPressHandler(_ sender: Any) {
        minusBPMValue()
    }
    
    @IBAction func addLongPressHandler(_ sender: Any) {
        addBPMValue()
    }
    
    // MARK: BPM Calculation Functions
    func minusBPMValue() {
        if MetronomeDataController.currentBPM > 40 {
            MetronomeDataController.currentBPM -= 1
            updateBPMLabel()
            updateMarkingUI()
            
            if beatTimer.isValid {
                triggerTimer()
            }
            
        }
    }
    
    func addBPMValue() {
        if MetronomeDataController.currentBPM < 240 {
            MetronomeDataController.currentBPM += 1
            updateBPMLabel()
            updateMarkingUI()
            
            if beatTimer.isValid {
                triggerTimer()
            }
        }
        
    }
    
    // MARK: UI Display
    func updateBPMLabel() {
        bpmLabelOutlet.text = String(MetronomeDataController.currentBPM)
    }
    
    func updateMarkingUI() {
        MetronomeDataController.markingConverter()
        tempoMarkingButtonOutlet.setTitle(MetronomeDataController.currentTempoMarking.rawValue, for: .normal)
    }
    
    
    // MARK: - Time Signature
    // TimeSigVC Delegate
    func passTimeSigInfo() {
//        currentTempo = tempo
       let timeSigStr = "\(MetronomeDataController.currentTimeSig[0]) / \(MetronomeDataController.currentTimeSig[1])"
        timeSigButtonOutlet.setTitle(timeSigStr, for: .normal)
        
        updateBeatUI(MetronomeDataController.currentTimeSig[0])
        
        if beatTimer.isValid {
            triggerTimer()
        }
//        print(tempoStr)
    }
    
    func updateBeatUI(_ topNum: Int) {
//        let showingImageNum = topNum - 1
    
        // change the range back to 0...15 when the number of images are back to 16
        for i in 0...15 {
            beatImageOutlets[i].isHidden = i < topNum ? false : true
        }
    }
    
    // MARK: - Tempo Marking
    // TempoMarking Delegate
    func updateTempoMarking() {
        tempoMarkingButtonOutlet.setTitle(MetronomeDataController.currentTempoMarking.rawValue, for: .normal)
        
        MetronomeDataController.speedConverter()
        bpmLabelOutlet.text = String(MetronomeDataController.currentBPM)
        
        if beatTimer.isValid {
            triggerTimer()
        }
    }
    
    
    // MARK: - Play
    @IBAction func playButtonPressed(_ sender: Any) {
        
        //change the button image according to button status
        let displayImage = beatTimer.isValid ?
            UIImage(named: "play.png") : UIImage(named: "stop.png")
        playButtonOutlet.setImage(displayImage, for: .normal)
        playButtonOutlet.layer.shadowOpacity = beatTimer.isValid ? 0.5 : 0
        
        if beatTimer.isValid {
            beatTimer.invalidate()
            timeTimer.invalidate()
        } else {
            triggerTimer()
        }
    }
    
    
    func triggerTimer() {
        beatTimer.invalidate()
        timeTimer.invalidate()
        
        var second = 0
        var beat = 0
        let topNum = MetronomeDataController.currentTimeSig[0]
        let buttonNum = MetronomeDataController.currentTimeSig[1]
        let timeInterval = 60.00 / Double(MetronomeDataController.currentBPM) / ( Double(buttonNum) / Double(4) )
        
        beatTimer =
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in
            
                beat += 1
                
                beat % topNum == 1 ? self.playSoundEffect("a") : self.playSoundEffect("b")
//                if beat % topNum == 1 {
//                    self.playSoundEffect("a")
//                } else {
//                    self.playSoundEffect("b")
//                }
                
            print("Beat: \(beat)")
            
        }
        
        timeTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.updateTimeLabel(second)
            second += 1
//            print("Time: \(second)")
            
        })
    }
    
    func updateTimeLabel(_ second: Int) {
        
        var minuteStr = "00"
        
        let minute = second / 60
        if minute == 0 {
            minuteStr = "00"
        } else if minute < 10 {
            minuteStr = "0\(second / 60)"
        } else {
            minuteStr = "\(second / 60)"
        }
        
        let secondStr = second % 60  < 10 ? "0\(second % 60)" : "\(second % 60)"
        
        timeLabel.text = minuteStr + ":" + secondStr
        
    }
    
    // MARK: - AVFoundation
    func playSoundEffect(_ order: String) {
        let effectFileUrl = Bundle.main.url(forResource: "sound1\(order)", withExtension: "mp3")!
        playerItem = AVPlayerItem(url: effectFileUrl)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    @IBAction func soundOnButtonPressed(_ sender: Any) {
        // change button image according to the isMuted status
        
        player.isMuted = !player.isMuted
        let displayImage = player.isMuted ? UIImage(named: "soundOff.png") : UIImage(named: "soundOn.png")
        soundOnButtonOutlet.setImage(displayImage, for: .normal)
        
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print(sender)
        let popoverController = segue.destination.popoverPresentationController
//        if sender is UIButton {
            popoverController?.sourceRect = (sender as! UIButton).bounds
//        }
        popoverController?.delegate = self
        
        let tempoVC = segue.destination as? TimeSigPickerVC
        tempoVC?.delegate = self
//        tempoVC?.pickerViewOutlet.selectRow(, inComponent: 0, animated: true)
        let markingVC = segue.destination as? TempoMarkingPickerVC
        markingVC?.delegate = self
        
    }
    
    // MARK: - Pop Over
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: - UI
    func updateUI() {
        beatBarOutlet.layer.cornerRadius = 16
        
        // Time Signature Button
        timeSigButtonOutlet.layer.cornerRadius = timeSigButtonOutlet.frame.height / 2
        timeSigButtonOutlet.layer.shadowOpacity = 0.5
        timeSigButtonOutlet.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        timeSigButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        // Sound On Button
        soundOnButtonOutlet.layer.shadowOpacity = 0.3
        soundOnButtonOutlet.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        soundOnButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        // Tempo Marking Button
        tempoMarkingButtonOutlet.setTitleColor(UIColor.white, for: .normal)
        tempoMarkingButtonOutlet.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tempoMarkingButtonOutlet.tintColor = UIColor.white
        tempoMarkingButtonOutlet.layer.cornerRadius = tempoMarkingButtonOutlet.frame.height / 2
        tempoMarkingButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
        tempoMarkingButtonOutlet.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tempoMarkingButtonOutlet.layer.shadowOpacity = 0.5
        
        // Play Button
        playButtonOutlet.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        playButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
        playButtonOutlet.layer.shadowOpacity = beatTimer.isValid ? 0 : 0.5
        
        
    }
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        
        bpmLabelOutlet.text = String(MetronomeDataController.currentBPM)

        updateBeatUI(MetronomeDataController.currentTimeSig[0])
    }


}

