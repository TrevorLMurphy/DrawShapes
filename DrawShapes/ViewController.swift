//
//  ViewController.swift
//  DrawShapes
//
//  Created by Trevor Murphy on 9/29/15.
//  Copyright © 2015 Trevor Murphy. All rights reserved.
//

import UIKit

@IBDesignable
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData = ["Circle", "Triangle", "Square", "Pentagon"]
    var selected: String = "Triangle"

    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 360
        picker.delegate = self
        picker.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = pickerData[row]
        let formattedTitle = NSAttributedString(
            string: title,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        )
        return formattedTitle
    }
    
    @IBAction func selected(sender: AnyObject) {
        self.performSegue(withIdentifier: "beginApp", sender: sender)
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        let currentValue = Int(sender.value)
        counter.text = "\(currentValue)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DrawCanvas
        vc.selected = selected
        vc.timesDrawn = Int(counter.text!)
    }
}

