//
//  TempoVC.swift
//  MyMetronome
//
//  Created by Penny Huang on 2020/6/5.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

protocol TempoVCDelegate: class {
    func passTempoInfo(tempo: [Int], tempoIndex:[Int])
}

class TempoPickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: TempoVCDelegate?
    
    let upperNum = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    let lowerNum = [1, 2, 4, 8, 16]
    var currentTempo = [4, 4]
    var currentTempoIndex = [3,2]
    
    @IBOutlet weak var pickerViewOutlet: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return upperNum.count
        case 1:
            return lowerNum.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        
        if component == 0 {
            let item = upperNum[row]
            return "\(item)"
        } else {
            let item = lowerNum[row]
            return "\(item)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            currentTempo[0] = upperNum[row]
            currentTempoIndex[0] = row
//            print(currentTempo)
        } else if component == 1 {
            currentTempo[1] = lowerNum[row]
            currentTempoIndex[1] = row
//            print(currentTempo)
        }
        delegate?.passTempoInfo(tempo: currentTempo, tempoIndex: currentTempoIndex)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
