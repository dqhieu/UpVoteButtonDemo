//
//  ViewController.swift
//  UpVoteButtonDemo
//
//  Created by Dinh Quang Hieu on 1/21/17.
//  Copyright © 2017 Dinh Quang Hieu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UpVoteButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button = UpVoteButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.voteCount = 24
        button.center = view.center
        button.delegate = self
        self.view.addSubview(button)
        view.backgroundColor = UIColor.gray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didChangeState(button: UpVoteButton, state: State) {
        // Do your stuff....
    }
}
