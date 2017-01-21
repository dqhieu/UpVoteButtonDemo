//
//  UpVoteButton.swift
//  UpVoteButtonDemo
//
//  Created by Dinh Quang Hieu on 1/21/17.
//  Copyright © 2017 Dinh Quang Hieu. All rights reserved.
//

import UIKit

protocol UpVoteButtonDelegate {
    func didChangeState(button: UpVoteButton, state: State)
}

enum State {
    case normal, highlighted
}

private struct Color {
    static let normal = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1.0)
    static let highlighted = UIColor(red: 255.0/255.0, green: 64.0/255.0, blue: 129.0/255.0, alpha: 1.0)
}

class UpVoteButton: UIView {

    var voteCount: Int {
        set(value) {
            textLbl.text = String(value)
            if state == .normal {
                highlighedTextLabel.text = String(value + 1)
            } else {
                highlighedTextLabel.text = String(value - 1)
            }
        }
        get {
            return Int(textLbl.text!)!
        }
    }
    
    var state: State = .normal {
        didSet {
            if state == .normal {
                normalView.alpha = 1
                textLbl.alpha = 0
                highlighedTextLabel.alpha = 1
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: [], animations: {
                    self.normalView.transform = CGAffineTransform(scaleX: 4, y: 4)
                    self.textLbl.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
                    self.highlighedTextLabel.frame = self.bottomFrame
                    self.textLbl.alpha = 1
                    self.highlighedTextLabel.alpha = 0
                }, completion: { (finished) in
                    self.highlighedView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.highlighedView.alpha = 0
                    self.normalView.alpha = 0
                })
                
            } else {
                highlighedView.alpha = 1
                normalView.alpha = 0
                textLbl.alpha = 0
                highlighedTextLabel.alpha = 1
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: [], animations: {
                    self.highlighedView.transform = CGAffineTransform(scaleX: 4, y: 4)
                    self.textLbl.frame = self.topFrame
                    self.highlighedTextLabel.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
                    self.textLbl.alpha = 0
                    self.highlighedTextLabel.alpha = 1
                }, completion: { (finished) in
                    self.normalView.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }
        }
    }
    
    private var topFrame: CGRect!
    private var bottomFrame: CGRect!
    
    private var textLbl: UILabel!
    private var highlighedTextLabel: UILabel!
    private var highlighedView: UIView!
    private var normalView: UIView!
    
    var delegate: UpVoteButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        topFrame = CGRect(x: frame.origin.x, y: frame.origin.y - frame.size.height / 2, width: frame.width, height: frame.height)
        bottomFrame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.size.height / 2, width: frame.width, height: frame.height)
        
        highlighedView = UIView()
        highlighedView.frame = CGRect(origin: frame.origin, size: CGSize(width: frame.size.width / 4, height: frame.size.height / 4))
        highlighedView.layer.cornerRadius = frame.width / 8
        highlighedView.backgroundColor = Color.highlighted
        highlighedView.center = center
        highlighedView.alpha = 0
        addSubview(highlighedView)
        
        normalView = UIView()
        normalView.frame = CGRect(origin: frame.origin, size: CGSize(width: frame.size.width / 4, height: frame.size.height / 4))
        normalView.layer.cornerRadius = frame.width / 8
        normalView.backgroundColor = Color.normal
        normalView.center = center
        normalView.alpha = 0
        addSubview(normalView)
        
        textLbl = UILabel()
        textLbl.frame = frame
        textLbl.center = center
        textLbl.textAlignment = .center
        textLbl.textColor = UIColor.black
        textLbl.font = UIFont.systemFont(ofSize: 20)
        addSubview(textLbl)
        
        highlighedTextLabel = UILabel()
        highlighedTextLabel.textColor = UIColor.white
        highlighedTextLabel.font = UIFont.systemFont(ofSize: 20)
        highlighedTextLabel.frame = bottomFrame
        highlighedTextLabel.textAlignment = .center
        highlighedTextLabel.alpha = 0
        addSubview(highlighedTextLabel)
        
        layer.cornerRadius = frame.width / 2
        backgroundColor = Color.normal
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap(sender:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTap(sender: UITapGestureRecognizer) {
        if state == .normal {
            state = .highlighted
        } else {
            state = .normal
        }
        delegate?.didChangeState(button: self, state: self.state)
    }
}
