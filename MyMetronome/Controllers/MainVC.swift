//
//  ViewController.swift
//  MyMetronome
//
//  Created by Penny Huang on 2020/5/31.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIPopoverPresentationControllerDelegate, TimeSigVCDelegate, TempoMarkingDelegate {

    var timer = Timer()
    var startPanlocation: CGPoint!
    
    @IBOutlet weak var tempoButtonOutlet: UIButton!
    
    @IBOutlet weak var bpmLabelOutlet: UILabel!
    
    @IBOutlet weak var tempoMarkingButtonOutlet: UIButton!
    
    @IBOutlet weak var minusButtonOutlet: UIButton!
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    @IBOutlet var beatImageOutlets: [UIImageView]!
    
    
    
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
            
            if timer.isValid {
                triggerTimer()
            }
            
        }
    }
    
    func addBPMValue() {
        if MetronomeDataController.currentBPM < 240 {
            MetronomeDataController.currentBPM += 1
            updateBPMLabel()
            updateMarkingUI()
            
            if timer.isValid {
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
       let tempoStr = "\(MetronomeDataController.currentTimeSig[0]) / \(MetronomeDataController.currentTimeSig[1])"
        tempoButtonOutlet.setTitle(tempoStr, for: .normal)
        
        updateBeatUI(MetronomeDataController.currentTimeSig[0])
        
        if timer.isValid {
            triggerTimer()
        }
//        print(tempoStr)
    }
    
    func updateBeatUI(_ topNum: Int) {
        let showingImageNum = topNum - 1
    
        // change the range back to 0...15 when the number of images are back to 16
        for i in 0...14 {
            beatImageOutlets[i].isHidden = i <= showingImageNum ? false : true
        }
    }
    
    // MARK: - Tempo Marking
    // TempoMarking Delegate
    func updateTempoMarking() {
        tempoMarkingButtonOutlet.setTitle(MetronomeDataController.currentTempoMarking.rawValue, for: .normal)
        
        MetronomeDataController.speedConverter()
        bpmLabelOutlet.text = String(MetronomeDataController.currentBPM)
        
        if timer.isValid {
            triggerTimer()
        }
    }
    
    
    // MARK: - Beat
    @IBAction func playButtonPressed(_ sender: Any) {
        if timer.isValid {
            timer.invalidate()
        } else {
            triggerTimer()
        }
    }
    
    
    func triggerTimer() {
        timer.invalidate()
        
        var time = 0
        let buttonNum = MetronomeDataController.currentTimeSig[1]
        let timeInterval = 60.00 / Double(MetronomeDataController.currentBPM) / ( Double(buttonNum) / Double(4) )
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in
            
            time += 1
            print(time)
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bpmLabelOutlet.text = String(MetronomeDataController.currentBPM)

    }


}

