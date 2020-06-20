//
//  ViewController.swift
//  MyMetronome
//
//  Created by Penny Huang on 2020/5/31.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIPopoverPresentationControllerDelegate, TimeSigVCDelegate, TempoMarkingDelegate {

    var speed: Double = 60
    var timer = Timer()
    var startPanlocation: CGPoint!
    
    @IBOutlet weak var tempoButtonOutlet: UIButton!
    
    @IBOutlet weak var bpmLabelOutlet: UILabel!
    
    @IBOutlet weak var tempoMarkingButtonOutlet: UIButton!
    
    // MARK: - BPM
    @IBAction func minusButtonPressed(_ sender: Any) {
        if MetronomeDataController.currentBPM > 40 {
            MetronomeDataController.currentBPM -= 1
            updateBPMLabel()
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if MetronomeDataController.currentBPM < 240 {
            MetronomeDataController.currentBPM += 1
            updateBPMLabel()
        }
    }
    
    func updateBPMLabel() {
        bpmLabelOutlet.text = String(MetronomeDataController.currentBPM)
    }
    
    
    
    // MARK: - TimeSigVC Delegate
    func passTimeSigInfo() {
//        currentTempo = tempo
       let tempoStr = "\(MetronomeDataController.currentTimeSig[0]) / \(MetronomeDataController.currentTimeSig[1])"
        tempoButtonOutlet.setTitle(tempoStr, for: .normal)
        
//        print(tempoStr)
    }
    
    // MARK: - TempoMarking Delegate
    func updateTempoMarking() {
        tempoMarkingButtonOutlet.setTitle(MetronomeDataController.tempoStatus.rawValue, for: .normal)
        
        MetronomeDataController.speedConverter()
        bpmLabelOutlet.text = String(MetronomeDataController.currentBPM)
    }
    
    
    // MARK: - Gesture
//    @IBAction func panHandler(_ sender: UIPanGestureRecognizer) {
//
//        if sender.state == .began {
//            startPanlocation = sender.location(in: sender.view)
//        } else if sender.state == .changed {
//            let stopLocation = sender.location(in: sender.view)
//            let abscissaChange = (stopLocation.y - startPanlocation.y)
//
//            if abscissaChange > 0 {
//                speed -= 0.1
//            } else if abscissaChange < 0 {
//                speed += 0.1
//            }
////            bpmTextFiledOutlet.text = String(Int(speed))
//            bpmLabelOutlet.text = String(Int(speed))
//        }
//
//    }
    
    

    // MARK: - Beat
    @IBAction func playButtonPressed(_ sender: Any) {
        if timer.isValid {
            timer.invalidate()
        } else {
            triggerTimer()
        }
    }
    
    
    func triggerTimer() {
        var time = 0
        timer = Timer.scheduledTimer(withTimeInterval: 60.00 / Double(speed), repeats: true) { (timer) in
            
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
    

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

