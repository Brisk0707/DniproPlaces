//
//  RaitingControl.swift
//  MyPlaces
//
//  Created by Борис Крисько on 22.10.2019.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import UIKit

@IBDesignable class RaitingControl: UIStackView { //IBDesignable uses for viewing changes in storyboard
    
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    @objc func ratingButtonTapped(button : UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else { return }
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    private func setupButtons() {
        
        for button in ratingButtons { //clear all previous buttons
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        //load button image
        let bundle = Bundle(for: type(of: self))
        
        let filledStar = UIImage(named: "filledStar",
                                 in: bundle,
                                 compatibleWith: self.traitCollection)
        
        let empyStar = UIImage(named: "emptyStar",
                               in: bundle,
                               compatibleWith: self.traitCollection)
        
        let blueStar = UIImage(named: "highlightedStar",
                               in: bundle,
                               compatibleWith: self.traitCollection)
        
        for _ in 1...starCount {
        let button = UIButton()
        
            button.setImage(empyStar, for: .normal) //default image
            button.setImage(filledStar, for: .selected) //when clicked
            button.setImage(blueStar, for: .highlighted) //when selected
            button.setImage(blueStar, for: [.highlighted, .selected])
        
        button.translatesAutoresizingMaskIntoConstraints = false //disable automatic constaints
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true //setting constraints
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        
        button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside) //setup button action
        
        addArrangedSubview(button) //add button to view
            
        ratingButtons.append(button)
            
            
        }
        
        updateButtonSelectionState()
    }

    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }

}
