//
//  ZTHBaseTextField.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 04/02/25.
//

import UIKit

@available(iOS 13.0, *)
class ZTHBaseTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    
    // Handle initialization from storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @available(iOS 13.0, *)
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius  = 10
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.systemGray4.cgColor
        
        adjustsFontSizeToFitWidth = true
        
        textColor           = .label
        tintColor           = .label
        textAlignment       = .center
        font                = UIFont.preferredFont(forTextStyle: .title2)
        minimumFontSize     = 12
        
        backgroundColor     = .tertiarySystemBackground
        autocorrectionType  = .no
        placeholder         = "Enter a Github username..."
        
        returnKeyType       = .go
    }
}
