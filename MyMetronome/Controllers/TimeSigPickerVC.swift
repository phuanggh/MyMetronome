//
//  TempoVC.swift
//  MyMetronome
//
//  Created by Penny Huang on 2020/6/5.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

protocol TimeSigVCDelegate: class {
    func passTimeSigInfo()
}

class TimeSigPickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: TimeSigVCDelegate?
    
    @IBOutlet weak var pickerOutlet: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return MetronomeDataController.topNum.count
        case 1:
            return MetronomeDataController.bottomNum.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if component == 0 {
            let item = MetronomeDataController.topNum[row]
            return "\(item)"
        } else {
            let item = MetronomeDataController.bottomNum[row]
            return "\(item)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            MetronomeDataController.currentTimeSig[0] = MetronomeDataController.topNum[row]
        } else if component == 1 {
            MetronomeDataController.currentTimeSig[1] = MetronomeDataController.bottomNum[row]
        }
        delegate?.passTimeSigInfo()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Top Num
        let selectedTopNum = MetronomeDataController.topNum.firstIndex(of: MetronomeDataController.currentTimeSig[0]) ?? 0
        
        pickerOutlet.selectRow(selectedTopNum, inComponent: 0, animated: false)
        
        // Bottom Num
        let selectedBottomNum = MetronomeDataController.bottomNum.firstIndex(of: MetronomeDataController.currentTimeSig[1]) ?? 0
        pickerOutlet.selectRow(selectedBottomNum, inComponent: 1, animated: false)

    }
    

}
