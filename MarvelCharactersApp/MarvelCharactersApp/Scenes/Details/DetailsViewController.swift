//
//  DetailsViewController.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol HomeDetailDelegate: AnyObject {
    func notifyCharacterFavoriteStatus(character: Character?)
}

protocol DetailsDisplayLogic: AnyObject {
    func displayCharacterInfo(viewModel: Details.CharacterInfo.ViewModel)
    func displayFavoriteStatus(viewModel: Details.SaveFavoriteStatus.ViewModel)
    func displayErrorMessage(viewModel: Details.ErrorMessage.ViewModel)
}

class DetailsViewController: UIViewController {
    var interactor: DetailsBusinessLogic?
    var router: (DetailsRoutingLogic & DetailsDataPassing)?
    
    weak var delegate: HomeDetailDelegate?
    
    var character: Character?
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .marvelRed
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    let detailTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.textAlignment = .justified
        textView.font = .systemFont(ofSize: 20)
        return textView
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage( UIImage(systemName: "star.fill"), for: .normal)
        
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFavoriteButtonTap(sender:))))
        return button
    }()
    
    // MARK: Object lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        interactor?.handleGetCharacterInfo(request: .init())
    }
    
    @objc func handleFavoriteButtonTap(sender: UITapGestureRecognizer) {
        interactor?.handleSaveFavoriteStatus(request: .init())
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        let worker = DetailsWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setupUI() {
        title = "Details"
        
        view.addSubview(characterImageView)
        view.addSubview(nameLabel)
        view.addSubview(detailTextView)
        view.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            characterImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            characterImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            nameLabel.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor, constant: -15),
            
            favoriteButton.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            favoriteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            favoriteButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
            favoriteButton.widthAnchor.constraint(equalTo: favoriteButton.heightAnchor),
            
            detailTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            detailTextView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            detailTextView.rightAnchor.constraint(equalTo: favoriteButton.rightAnchor),
            detailTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension DetailsViewController: DetailsDisplayLogic {
    func displayCharacterInfo(viewModel: Details.CharacterInfo.ViewModel) {
        self.character = viewModel.character
        self.nameLabel.text = viewModel.name
        self.detailTextView.text = viewModel.detail
        self.characterImageView.image = viewModel.image
        
        favoriteButton.tintColor = (self.character?.isFavorite ?? false) ? .yellow : .lightGray
    }
    
    func displayFavoriteStatus(viewModel: Details.SaveFavoriteStatus.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.character = viewModel.character
            self?.nameLabel.text = viewModel.name
            self?.detailTextView.text = viewModel.detail
            self?.characterImageView.image = viewModel.image
            
            self?.favoriteButton.tintColor = (self?.character?.isFavorite ?? false) ? .yellow : .lightGray
            self?.delegate?.notifyCharacterFavoriteStatus(character: self?.character)
        }
    }
    
    func displayErrorMessage(viewModel: Details.ErrorMessage.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            ErrorAlert.presentError(in: self, with: viewModel.message)
        }
    }
}
