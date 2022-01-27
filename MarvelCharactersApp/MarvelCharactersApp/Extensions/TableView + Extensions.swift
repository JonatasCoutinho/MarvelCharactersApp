//
//  TableView + Extensions.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 27/01/22.
//

import UIKit

extension UITableView {

    func setupEmptyEmptyView(_ message: String) {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        emptyView.backgroundColor = .black
        
        let emptyImage = UIImageView()
        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        emptyImage.image = UIImage(systemName: "exclamationmark.triangle")
        emptyImage.tintColor = .white
        emptyView.addSubview(emptyImage)
        
        
        let emptyLabel = UILabel()
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = message
        emptyLabel.textColor = .white
        emptyLabel.numberOfLines = 0
        emptyLabel.textAlignment = .center
        emptyLabel.font = .systemFont(ofSize: 25)
        emptyLabel.sizeToFit()
        emptyView.addSubview(emptyLabel)

        self.backgroundView = emptyView
        self.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            emptyImage.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 50),
            emptyImage.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyImage.heightAnchor.constraint(equalToConstant: emptyView.frame.height * 0.3),
            emptyImage.widthAnchor.constraint(equalTo: emptyImage.heightAnchor),
            
            emptyLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyLabel.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: 15)
        ])
    }
    
    func setupLoadView() {
        let loadView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        loadView.backgroundColor = .black
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.backgroundColor = .clear
        activityIndicator.startAnimating()
        loadView.addSubview(activityIndicator)
        
        self.backgroundView = loadView
        self.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadView.centerYAnchor)
        ])
    }

    func removeBackGroundView() {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyView.backgroundColor = .black
        
        self.backgroundView = emptyView
        self.separatorStyle = .singleLine
    }
}
