//
//  FavoriteCharacterCell.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 23/01/22.
//

import UIKit

class FavoriteCharacterCell: UITableViewCell {
    private var character: FavoriteCharacter?
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        addViews()
    }
    
    func setCharacter(character: FavoriteCharacter) {
        self.character = character
        
        nameLabel.text = (character.name?.isEmpty ?? true) ? "Unavailable Name" : character.name
        
        guard let imageData = character.image else {
            return
        }
        
        characterImageView.image = UIImage(data: imageData)
    }
    
    func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .black
    }
    
    func addViews() {
        addSubview(nameLabel)
        addSubview(characterImageView)
        
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
        
        NSLayoutConstraint.activate([
        characterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        characterImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
        characterImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
        characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor),
        
        nameLabel.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor),
        nameLabel.leftAnchor.constraint(equalTo: characterImageView.rightAnchor, constant: 15),
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15)
        ])
    }
}
