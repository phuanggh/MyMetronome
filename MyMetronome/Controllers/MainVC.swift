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
    
    // MARK: - BPM
    @IBAction func minusButtonPressed(_ sender: Any) {
        minusBPM()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        addBPM()
    }
    
    // MARK: Gesture
    @IBAction func minusLongPressHandler(_ sender: Any) {
        minusBPM()
    }
    
    @IBAction func addLongPressHandler(_ sender: Any) {
        addBPM()
    }
    
    // MARK: BPM Calculation Functions
    func minusBPM() {
        if MetronomeDataController.currentBPM > 40 {
            MetronomeDataController.currentBPM -= 1
            updateBPMLabel()
            
            if timer.isValid {
                triggerTimer()
            }
            
        }
    }
    
    func addBPM() {
        if MetronomeDataController.currentBPM < 240 {
            MetronomeDataController.currentBPM += 1
            updateBPMLabel()
            
            if timer.isValid {
                triggerTimer()
            }
        }
        
    }
    
    // MARK: BPM Display
    func updateBPMLabel() {
        bpmLabelOutlet.text = String(MetronomeDataController.currentBPM)
    }
    
    
    // MARK: - Time Signature
    // TimeSigVC Delegate
    func passTimeSigInfo() {
//        currentTempo = tempo
       let tempoStr = "\(MetronomeDataController.currentTimeSig[0]) / \(MetronomeDataController.currentTimeSig[1])"
        tempoButtonOutlet.setTitle(tempoStr, for: .normal)
        
        if timer.isValid {
            triggerTimer()
        }
//        print(tempoStr)
    }
    
    // MARK: - Tempo Marking
    // TempoMarking Delegate
    func updateTempoMarking() {
        tempoMarkingButtonOutlet.setTitle(MetronomeDataController.tempoStatus.rawValue, for: .normal)
        
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

