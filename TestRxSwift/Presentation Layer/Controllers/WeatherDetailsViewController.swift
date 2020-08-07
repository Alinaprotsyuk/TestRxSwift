//
//  WeatherDetailViewController.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 07.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: WeatherDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfWeatherModel> (
          configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = item.key.capitalized
            cell.detailTextLabel?.text = item.temp.convertTempToString()
            return cell
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
          return dataSource.sectionModels[index].header
        }
        
        let sections = [
            SectionOfWeatherModel(header: "Temperature:", items: viewModel.temperatureData[0]),
            SectionOfWeatherModel(header: "Feels like:", items: viewModel.temperatureData[1])
        ]

        Observable.just(sections)
          .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: viewModel.bag)
    }
}


