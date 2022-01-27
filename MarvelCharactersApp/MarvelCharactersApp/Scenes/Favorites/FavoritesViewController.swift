//
//  FavoritesViewController.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func displayFavoriteCharacters(viewModel: Favorites.FetchFavorites.ViewModel)
    func displayErrorMessage(viewModel: Favorites.ErrorMessage.ViewModel)
}

class FavoritesViewController: UIViewController {
    var interactor: FavoritesBusinessLogic?
    var router:  (FavoritesRoutingLogic & FavoritesDataPassing)?
    
    var characters: [FavoriteCharacter] = []
    var isFirsCharactersLoad = true
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(sender:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        
        var attributes = [NSAttributedString.Key: AnyObject]()
        attributes[.foregroundColor] = UIColor.white

        let attributedString = NSAttributedString(string: "Refreshing characters...", attributes: attributes)

        refreshControl.attributedTitle = attributedString
        
        return refreshControl
    }()
    
    lazy var charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteCharacterCell.self, forCellReuseIdentifier: String(describing: FavoriteCharacterCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControl
        
        return tableView
    }()
    
    @objc func refreshWeatherData(sender: UITapGestureRecognizer) {
        interactor?.handleFetchFavoriteCharacters(request: .init())
    }
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.handleFetchFavoriteCharacters(request: .init())
        setupUI()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        let worker = FavoritesWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setupUI() {
        self.view.backgroundColor = .black
        self.charactersTableView.backgroundView?.backgroundColor = .black
        self.charactersTableView.separatorColor = .white
        
        view.addSubview(charactersTableView)
        
        NSLayoutConstraint.activate([
            charactersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charactersTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            charactersTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoritesViewController: FavoritesDisplayLogic {
    func displayFavoriteCharacters(viewModel: Favorites.FetchFavorites.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.characters = viewModel.characters
            self?.isFirsCharactersLoad = false
            self?.charactersTableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    func displayErrorMessage(viewModel: Favorites.ErrorMessage.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.isFirsCharactersLoad = false
            self.charactersTableView.reloadData()
            ErrorAlert.presentError(in: self, with: viewModel.message)
        }
    }
}

// MARK: TableView Delegate and DataSource
extension FavoritesViewController: UITableViewDelegate {
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFirsCharactersLoad {
            tableView.setupLoadView()
        }else if characters.isEmpty {
            tableView.setupEmptyEmptyView("Characters could not be loaded")
        }else {
            tableView.removeBackGroundView()
        }
        
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteCharacterCell.self), for: indexPath) as? FavoriteCharacterCell else {
            return UITableViewCell()
        }
        
        cell.setCharacter(character: characters[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
