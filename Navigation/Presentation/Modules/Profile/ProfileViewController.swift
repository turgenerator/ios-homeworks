//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Nikita Turgenev on 25.03.2022.
//

import UIKit

    // MARK: - PROTOCOLS

final class ProfileViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private var dataSource: [News.Article] = [] // МАССИВ НОВОСТЕЙ
    
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    private lazy var tableView: UITableView = { // создаем таблвью
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "TableHeder")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        return tableView
    }()
    
    private var isExpanded: Bool = true
    
    // MARK: LIFECYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tapGesturt()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchArticles { [weak self] articles in
            self?.dataSource = articles
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - SETUP SUBVIEW
    
    private func setupTableView() { // констрейны к таблвью
        self.view.addSubview(self.tableView)
        
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ])
    }
    
    // MARK: - Data coder
    
    private func fetchArticles(completion: @escaping ([News.Article]) -> Void) { // получаем новости
        if let path = Bundle.main.path(forResource: "news", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let news = try self.jsonDecoder.decode(News.self, from: data)
                print("json data: \(news)")
                completion(news.articles)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            fatalError("Invalid filename/path.")
        }
    }
    
    func tapGesturt() { // метод скрытия клавиатуры при нажатии на экран
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
}

    // MARK: - EXTENSIONS

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { // HEADER
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeder") as! ProfileTableHeaderView
        view.delegate = self
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            
            return isExpanded ? 220 : 250 // ВЫСОТА HEADER
        } else {
            
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
            return 1
        } else {
            
            return dataSource.count // КОЛИЧЕСТВО ПОСТОВ В СЕКЦИИ
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { // ЯЧЕЙКА ФОТОГРАФИЙ
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                
                return cell
            }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
            
            return cell
        } else { // ЯЧЕЙКИ ПОСТЫ
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                
                return cell
            }
            cell.selectionStyle = .none
            cell.delegate = self
            let article = dataSource[indexPath.row]
            let viewModel = PostTableViewCell.ViewModel(
                author: article.author,
                description: article.description,
                image: article.image,
                likes: article.likes,
                views: article.views)
            cell.setup(with: viewModel)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { // УДАЛЕНИЕ ЯЧЕЙКИ ТОЛЬКО ИЗ СЕКЦИЙ ПОСТОВ
        if indexPath.section == 0 {

            return .none
        } else {

            return .delete
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // УДАЛЕНИЕ ЯЧЕЙКИ
        self.tableView.beginUpdates()
        dataSource.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
       
    }
}

extension ProfileViewController: ProfileTableHeaderViewProtocol {
    func delegateAction(cell: ProfileTableHeaderView) {
        //
    }
    
    
    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void) { // АНИМАЦИЯ HEADER
        self.tableView.beginUpdates()
        self.isExpanded = !inputTextIsVisible
        self.tableView.endUpdates()
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
    
    
    
    func delegateActionAnimatedAvatar(cell: ProfileTableHeaderView) { // АНИМАЦИЯ АВАТАР
        let animatedAvatarViewController = AnimatedAvatarViewController()
        self.view.addSubview(animatedAvatarViewController.view)
        self.addChild(animatedAvatarViewController)
        animatedAvatarViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animatedAvatarViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animatedAvatarViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animatedAvatarViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            animatedAvatarViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    
        animatedAvatarViewController.didMove(toParent: self)
    }
}

extension ProfileViewController: PhotosTableViewCellProtocol { // ПЕРЕХОД К ФОТОГРАФИЯМ
    
    func delegateButtonAction(cell: PhotosTableViewCell) {
        let photosViewController = PhotosViewController()
        self.navigationController?.pushViewController(photosViewController, animated: true)
    }
}

extension ProfileViewController: PostTableViewCellProtocol { // НАЖАТИЕ НА LIKE И IMAGE

    func tapPostImageViewGestureRecognizerDelegate(cell: PostTableViewCell) { // УВЕЛИЧЕНИЕ ПРОСМОТРОВ
        let presentPostViewController = FullPostView()
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 1)
        let article = dataSource[indexPath.row]

        let viewModel = FullPostView.ViewModel(
            author: article.author,
            description: article.description,
            image: article.image,
            likes: article.likes,
            views: article.views)

        presentPostViewController.setup(with: viewModel)
        self.view.addSubview(presentPostViewController)

        presentPostViewController.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            presentPostViewController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            presentPostViewController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            presentPostViewController.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            presentPostViewController.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        dataSource[indexPath.row].views += 1
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }

    func tapLikeTitleGestureRecognizerDelegate(cell: PostTableViewCell) { // УВЕЛИЧЕНИЕ ЛАЙКОВ
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 1)
        dataSource[index].likes += 1
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
