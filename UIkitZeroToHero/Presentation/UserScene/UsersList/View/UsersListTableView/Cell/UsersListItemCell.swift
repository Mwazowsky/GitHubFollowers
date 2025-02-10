//
//  UsersListItemCell.swift
//  UIkitZeroToHero
//
//  Created by Saifulloh Fadli on 07/02/25.
//

import UIKit

final class UsersListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: UsersListItemCell.self)
    static let height = CGFloat(100)

    // MARK: - UI Components
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var viewModel: UsersListItemViewModel!
    private var profileImagesRepository: ProfileImagesRepository?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType = DispatchQueue.main

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupViews() {
        // Add subviews
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)

        // Layout constraints
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),

            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

            emailLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Configuration
    func fill(with viewModel: UsersListItemViewModel, profileImagesRepository: ProfileImagesRepository?) {
        self.viewModel = viewModel
        self.profileImagesRepository = profileImagesRepository

        nameLabel.text = viewModel.name
        emailLabel.text = viewModel.email
        updateProfileImage(width: Int(profileImageView.imageSizeAfterAspectFit.scaledSize.width))
    }

    private func updateProfileImage(width: Int) {
        profileImageView.image = nil
        guard let imagePath = viewModel.profileImagePath else {
            profileImageView.image = UIImage(named: "placeholder")
            return
        }

        imageLoadTask = profileImagesRepository?.fetchImage(with: imagePath, width: width) { [weak self] result in
            self?.mainQueue.async {
                guard self?.viewModel.profileImagePath == imagePath else { return }
                if case let .success(data) = result {
                    self?.profileImageView.image = UIImage(data: data)
                } else {
                    self?.profileImageView.image = UIImage(named: "placeholder")
                }
                self?.imageLoadTask = nil
            }
        }
    }

    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        emailLabel.text = nil
        imageLoadTask?.cancel()
    }
}
