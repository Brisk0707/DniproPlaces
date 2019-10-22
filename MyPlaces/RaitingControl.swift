//
//  RaitingControl.swift
//  MyPlaces
//
//  Created by Борис Крисько on 22.10.2019.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import UIKit

@IBDesignable class RaitingControl: UIStackView { //IBDesignable uses for viewing changes in storyboard
    
    private var ratingButtons = [UIButton]() //array with buttons
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){ //IBInspectable for editing from storyboard
        didSet { //didset for apply changes from storyboard
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    var rating = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    @objc func ratingButtonTapped(button : UIButton) {
        print("Button pressed")
    }
    
    private func setupButtons() {
        
        for button in ratingButtons { //clear all previous buttons
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        for _ in 0...starCount {
        let button = UIButton()
        button.backgroundColor = .red
        
        
        button.translatesAutoresizingMaskIntoConstraints = false //disable automatic constaints
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true //setting constraints
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        
        button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside) //setup button action
        
        addArrangedSubview(button) //add button to view
            
        ratingButtons.append(button)
        }
    }


}
