//
//  ViewController.swift
//  MyMetronome
//
//  Created by Penny Huang on 2020/5/31.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIPopoverPresentationControllerDelegate, TempoVCDelegate, TempoMarkingDelegate {

    var speed: Double = 60
    var timer = Timer()
    var startPanlocation: CGPoint!
    
    @IBOutlet weak var tempoButtonOutlet: UIButton!
//    @IBOutlet weak var speedImageOutlet: UIImageView!
//    @IBOutlet weak var bpmTextFiledOutlet: UITextField!
    
    @IBOutlet weak var bpmLabelOutlet: UILabel!
    
    @IBOutlet weak var tempoMarkingButtonOutlet: UIButton!
    
//    @IBAction func bpmEditingDidChanged(_ sender: Any) {
//        print("end editing")
//        if let bpmValue = Double(bpmTextFiledOutlet.text!) {
//            speed = bpmValue
//            timer.invalidate()
//            triggerTimer()
//            print("editing did end")
//        } else {
//            print("invalid bpm value")
//        }
//
//    }
    
    
    // MARK: - TempoVC Delegate
    func passTempoInfo() {
//        currentTempo = tempo
       let tempoStr = "\(MetronomeDataController.currentTimeSig[0]) / \(MetronomeDataController.currentTimeSig[1])"
        tempoButtonOutlet.setTitle(tempoStr, for: .normal)
        
        print(tempoStr)
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
        print(sender)
        let popoverController = segue.destination.popoverPresentationController
//        if sender is UIButton {
            popoverController?.sourceRect = (sender as! UIButton).bounds
//        }
        popoverController?.delegate = self
        
        let tempoVC = segue.destination as? TempoPickerVC
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

