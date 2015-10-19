//
//  ViewController.swift
//  DrawShapes
//
//  Created by Trevor Murphy on 9/29/15.
//  Copyright © 2015 Trevor Murphy. All rights reserved.
//

import UIKit

@IBDesignable
class ViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var mySlider: UISlider!
    var shapes = ["Circle", "Triangle", "Square", "Pentagon"]
    var selected: String = "Circle"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shapes.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shapes[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = shapes[row]
    }
    
    @IBAction func selected(sender: AnyObject) {
        self.performSegueWithIdentifier("beginApp", sender:sender)
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        let currentValue = Int(sender.value)
        myLabel.text = "\(currentValue)"
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Create a new variable to store the instance of the next view controller
        let vc = segue.destinationViewController as! DrawCanvas
        vc.selected = selected
        vc.timesDrawn = Int(myLabel.text!)
    }
}

