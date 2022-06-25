//
//  MostPopularVC.swift
//  NYTimesApp
//
//  Created by Arvind on 22/06/22.
//

import UIKit

class MostPopularVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var viewModel = MostPopularVM(httpClient: HTTPClient())
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "NY Times Most Popular"
        tableView.register(UINib(nibName: "MostPopularTVCell", bundle: nil), forCellReuseIdentifier: "MostPopularTVCell")
        setUpNavigationBar()
        getMostPopularData()
    }
    
    deinit {
        print("MostPopularVC is DeINTIALIZED")
    }
    
    // MARK: - Custom Methods
    private func getMostPopularData() {
        viewModel.getMostPopularNews { message, status in
            if status {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setUpNavigationBar() {
        let menuButton = getBarButton("menu")
        let searchButton = getBarButton("search")
        let moreButton = getBarButton("more")
        menuButton.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        let searchBarButton = UIBarButtonItem(customView: searchButton)
        let moreBarButton = UIBarButtonItem(customView: moreButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        navigationItem.rightBarButtonItems = [moreBarButton, searchBarButton]
    }
    
    private func getBarButton(_ name: String) -> UIButton {
        let barButton = UIButton(type: .system)
        barButton.setImage(UIImage(named: name), for: .normal)
        barButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return barButton
    }
    
    @objc private func menuAction() {
        print("Menu Button Tapped")
    }
    
    @objc private func searchAction() {
        print("Search Button Tapped")
    }
    
    @objc private func moreAction() {
        print("More Button Tapped")
    }
}

// MARK: - UITableView Datasource
extension MostPopularVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MostPopularTVCell") as! MostPopularTVCell
        cell.mostResult = viewModel.results?[indexPath.row]
        
        return cell
    }
}
