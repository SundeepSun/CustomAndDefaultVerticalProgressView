//
//  ViewController.swift
//  VerticalProgressView
//
//  Created by Shivakumar, Sundeep on 3/29/17.
//  Copyright © 2017 com.Sundeep.Learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // THis is custom Progress view
    var progessView:VerticalProgressView!

    // We can also use default progress view given by UIKIT
    var defaultProgressView:UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Custom Progress view
        progessView = VerticalProgressView(frame: CGRect(x: 0, y: 160, width: 15, height: 200))
        progessView.center.x = self.view.center.x - 80
        self.view.addSubview(progessView)

        //Default Progress view
        defaultProgressView = UIProgressView(progressViewStyle: .bar)
        self.view.addSubview(defaultProgressView)
    }
    
    override func viewDidLayoutSubviews() {
    
        defaultProgressView.frame = CGRect(x: self.view.center.x + 30, y: 300, width: 100, height: 300)
        defaultProgressView.progressTintColor = UIColor.green
        defaultProgressView.backgroundColor = UIColor.black
    
        // Change the width of default Progress view
        let customWidth = CGAffineTransform(scaleX: 5.0, y: 3.0)
        // Transform from default horizontal to vertical
        let rotate = CGAffineTransform(rotationAngle: (CGFloat.pi/2 + CGFloat.pi))
        
        //Two transforms should be concated and applied
        defaultProgressView.transform = rotate.concatenating(customWidth)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.progessView.setProgress(progress: 0.50, animated: true)
        UIView.animate(withDuration: 0.95) {
            self.defaultProgressView.setProgress(0.50, animated: true)
        }
    }
}

