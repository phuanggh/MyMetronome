//
//  TempoMarkingPickerVCViewController.swift
//  MyMetronome
//
//  Created by Penny Huang on 2020/6/13.
//  Copyright © 2020 Penny Huang. All rights reserved.
//

import UIKit

protocol TempoMarkingDelegate: class {
    func updateTempoMarking()
}

class TempoMarkingPickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: TempoMarkingDelegate?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TempoMarkings.tempoArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return TempoMarkings.tempoArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        MetronomeDataController.tempoStatus = TempoMarkings.allCases[row]
        delegate?.updateTempoMarking()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

}
