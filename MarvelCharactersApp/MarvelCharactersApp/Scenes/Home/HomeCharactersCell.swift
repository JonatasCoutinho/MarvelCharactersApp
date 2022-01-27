//
//  HomeCharactersCell.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 21/01/22.
//

import Foundation
import UIKit

protocol HomeCellDelegate: AnyObject {
    func handleUpdateFavoriteCharacterStatus(character: Character?)
}

class HomeCharactersCell: UITableViewCell {
    private var character: Character?
    var delegate: HomeCellDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .marvelRed
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage( UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = .lightGray
        
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFavoriteButtonTap(sender:))))
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        addViews()
    }
                         
    @objc func handleFavoriteButtonTap(sender: UITapGestureRecognizer) {
        let isFavorite = !(character?.isFavorite ?? false)
        character?.isFavorite = isFavorite
        delegate?.handleUpdateFavoriteCharacterStatus(character: character)
    }
    
    func setCharacter(character: Character) {
        self.character = character
        
        nameLabel.text = (character.name?.isEmpty ?? true) ? "Unavailable Name" : character.name
        characterImageView.image = character.image
        favoriteButton.tintColor = (character.isFavorite ?? false) ? .yellow : .lightGray
    }
    
    func getCharacterID() -> Int {
        character?.id ?? 0
    }
    
    func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .black
    }
    
    func addViews() {
        addSubview(nameLabel)
        addSubview(characterImageView)
        addSubview(favoriteButton)
        
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
        
        NSLayoutConstraint.activate([
        characterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        characterImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
        characterImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
        characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor),
        
        nameLabel.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor),
        nameLabel.leftAnchor.constraint(equalTo: characterImageView.rightAnchor, constant: 15),
        nameLabel.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor, constant: -15),
        
        favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        favoriteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
        favoriteButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
        favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor)
        ])
    }
}
