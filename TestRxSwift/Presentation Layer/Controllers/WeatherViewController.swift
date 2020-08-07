//
//  WeatherViewController.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 05.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: WeatherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel =  WeatherViewModel(locationManager: LocationManager(), networkManager: WeatherFetcher())
        
        viewModel
            .weatherList
            .map({ !$0.isEmpty })
            .bind(to: hintLabel.rx.isHidden)
            .disposed(by: viewModel.bag)
        
        viewModel
            .weatherList
            .map({ $0.isEmpty })
            .bind(to: tableView.rx.isHidden)
            .disposed(by: viewModel.bag)
        
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                guard let text = text else { return }
                self?.hintLabel.isHidden = false
                self?.hintLabel.text = text
                self?.tableView.isHidden = true
        })
        .disposed(by: viewModel.bag)
        
        tableView.register(UINib(nibName: WeatherTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: WeatherTableViewCell.identifier)
        viewModel
            .weatherList
            .bind(to: tableView
                .rx
                .items(cellIdentifier: WeatherTableViewCell.identifier)) { (index, model, cell) in
                    (cell as? WeatherTableViewCell)?.setup(weather: model)
        }
        .disposed(by: viewModel.bag)
        
        tableView.rx
            .modelSelected(WeatherList.self)
            .subscribe(onNext: { [weak self] list in
                self?.performSegue(withIdentifier: "detailsScreen", sender: list)
            })
            .disposed(by: viewModel.bag)
        
        segmentedControl.rx
            .selectedSegmentIndex
            .subscribe (onNext: { [weak self] index in
                if index == 1 {
                    self?.createNavSearchController()
                } else {
                    self?.hideNavSearchController()
                }
        }).disposed(by: viewModel.bag)
        
        searchController.searchBar.rx.text.orEmpty
        .throttle(.microseconds(3000), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .subscribe(onNext: { [weak self] (text) in
            self?.viewModel.fetchWeatherByCity(name: text)
        })
        .disposed(by: viewModel.bag)
    }
    
    private func createNavSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search weather by city name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func hideNavSearchController() {
        viewModel.fetchWeatherFromCurrentLocation()
        navigationItem.searchController = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = self.identifier(forSegue: segue)
        switch identifier {
        case .detailsScreen:
            guard let destination = segue.destination as? WeatherDetailsViewController,
                let list = sender as? WeatherList else {
                    assertionFailure("Couldn't get chocolate is coming VC!")
                    return
            }
            destination.title = viewModel.city?.name
            destination.viewModel = WeatherDetailsViewModel(list: list)
        }
    }
}

// MARK: - SegueHandler
extension WeatherViewController: SegueHandler {
  enum SegueIdentifier: String {
    case detailsScreen
  }
}
