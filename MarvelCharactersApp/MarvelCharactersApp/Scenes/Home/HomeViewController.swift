//
//  HomeViewController.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayCharacters(viewModel: Home.FetchCharacters.ViewModel)
    func displayFilterCharacters(viewModel: Home.FetchCharacters.ViewModel)
    func displayUpdateFavoriteCharacter(viewModel: Home.UpdateCharacter.ViewModel)
    func displayFavoriteStatus(viewModel: Home.SaveFavoriteStatus.ViewModel)
    func displayErrorMessage(viewModel: Home.ErrorMessage.ViewModel)
}

class HomeViewController: UIViewController {
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    
    var characters: [Character] = []
    private var isFirsCharactersLoad: Bool = true
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = .black
        searchController.searchBar.tintColor = .marvelRed
        searchController.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 1, green: 0.1098039225, blue: 0.05098039284, alpha: 0.5374064667)
        
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search Characters", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        if let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField,
           let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
            
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = .white
        }
        
        return searchController
    }()
    
    lazy var charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeCharactersCell.self, forCellReuseIdentifier: String(describing: HomeCharactersCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        
        interactor?.handleFetchCharactersList(request: .init())
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        let worker = HomeWorker()
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
        self.navigationItem.searchController = searchController
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

// MARK: Display Logic
extension HomeViewController: HomeDisplayLogic {
    func displayCharacters(viewModel: Home.FetchCharacters.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.characters = viewModel.characters ?? []
            self?.isFirsCharactersLoad = false
            self?.charactersTableView.reloadData()
        }
    }
    
    func displayFilterCharacters(viewModel: Home.FetchCharacters.ViewModel) {
        characters = viewModel.characters ?? []
        charactersTableView.reloadData()
    }
    
    func displayUpdateFavoriteCharacter(viewModel: Home.UpdateCharacter.ViewModel) {
        searchController.searchBar.endEditing(true)
        characters = viewModel.characters ?? []
        charactersTableView.reloadData()
    }
    
    func displayFavoriteStatus(viewModel: Home.SaveFavoriteStatus.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.characters = viewModel.characters ?? []
            self?.charactersTableView.reloadData()
        }
    }
    
    func displayErrorMessage(viewModel: Home.ErrorMessage.ViewModel) {
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
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? HomeCharactersCell else {
            return
        }
        
        router?.routeToDetailScreen(characterID: cell.getCharacterID())
    }
}

extension HomeViewController: UITableViewDataSource {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeCharactersCell.self), for: indexPath) as? HomeCharactersCell else {
            return UITableViewCell()
        }
        
        cell.setCharacter(character: characters[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: Search Controller Delegate

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        interactor?.handleFilterCharacters(request: .init(searchText: searchController.searchBar.text))
    }
}

extension HomeViewController: HomeDetailDelegate {
    func notifyCharacterFavoriteStatus(character: Character?) {
        interactor?.handleUpdateFavoriteCharacter(request: .init(character: character))
    }
}

extension HomeViewController: HomeCellDelegate {
    func handleUpdateFavoriteCharacterStatus(character: Character?) {
        interactor?.handleSaveFavoriteStatus(request: .init(character: character))
    }
}
    
