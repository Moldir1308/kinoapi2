//
//  ViewController.swift
//  Api2
//
//  Created by Ualikhan Sabden on 21.10.2023.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {
    
    var mainData: MoviesResult?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        setupSignals()
        getData()
    }

    func setupLayouts() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    func setupSignals() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        tableView.delegate = self
    }

    func getData() {
        Service.shared.fetchJsonData(urlString: "https://api.themoviedb.org/3/discover/movie") { result, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            
            if let result = result {
                self.mainData = result
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainData?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MainTableViewCell
        cell.backgroundColor = .red
        if let data = mainData?.results[indexPath.row] {
            cell.nameLabel.text = data.title
            cell.descLabel.text = data.overview
            if let path = data.posterPath{
                let imageUrl = "https://image.tmdb.org/t/p/w300_and_h450_bestv2/"
                guard let url = URL (string: imageUrl + path) else { return cell}
                cell.customImageView.sd_setImage(with:url)
            }
        }
        return cell
    }
    
    
}
class MainTableViewCell: UITableViewCell {
    
    lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "posterDemo")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Expend4"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .brown
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.text = "Armed with every weapon they can get their hands on and the skills to use them"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayouts() {
        addSubview(customImageView)
        customImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        customImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        customImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        customImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: customImageView.rightAnchor, constant: 20).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        addSubview(descLabel)
        descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30).isActive = true
        descLabel.leftAnchor.constraint(equalTo: customImageView.rightAnchor, constant: 20).isActive = true
        descLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
}


// MARK: - SwiftUI
import SwiftUI
@available(iOS 13.0, *)
struct MainVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
        }
        
        
        let mainVC = MainViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainVCProvider.ContainerView>) -> MainViewController {
            return mainVC
        }
        
        
    }
}
