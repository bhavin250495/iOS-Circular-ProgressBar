//
//  ViewController.swift
//  ProgressBarDemo
//
//  Created by Bhavin Suthar on 29/01/19.
//  Copyright © 2019 cazzy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circularProgress: CircularProgressBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var i_progress = 0.0
        var o_progress = 0.0
        self.circularProgress.showProgressText = true
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {_ in
            if i_progress >= 1.0 {
                i_progress = 0.0
            }
            if o_progress >= 1.0 {
                o_progress = 0.0
            }
            
            i_progress += 0.1
            o_progress += 0.2
            self.circularProgress.innerProgress = CGFloat(i_progress)
            self.circularProgress.outerProgress = CGFloat(o_progress)
            self.circularProgress.progress = CGFloat(i_progress)
        })
    }


}

