//
//  DrawCanvas.swift
//  DrawShapes
//
//  Created by Trevor Murphy on 9/30/15.
//  Copyright © 2015 Trevor Murphy. All rights reserved.
//

import UIKit

class DrawCanvas: UIViewController {
    
    @IBOutlet var DrawView: Shapes!
    @IBOutlet var doubleTap: UITapGestureRecognizer!
    
    var selected: String!
    var timesDrawn: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DrawView.whichShape = selected
        DrawView.timesDrawn = timesDrawn
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doubleTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }

}
