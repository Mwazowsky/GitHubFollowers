//
//  FollowersButton.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 03/02/25.
//

import UIKit

class ZTHFollowerButton: UIButton {
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        // Set properties before calling configure, if needed
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
        self.configure()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    
    // Handle initialization from storyboard (if needed, you can add a similar custom init here)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}
