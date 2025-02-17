//
//  ZTHFavoritesTableViewCell.swift
//  UIkitZeroToHero
//
//  Created by MacBook Air MII  on 05/02/25.
//

import UIKit

class ZTHFavoritesTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "ZTHFavoriteCell"
    
    private let favoriteUserLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure(with favoriteData: Favorite) {
        favoriteUserLabel.text = favoriteData.favoriteUser
    }
}
