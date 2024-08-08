//
//  SearchCityTableViewController.swift
//  WeatherForecast
//
//  Created by httruc on 8/8/24.
//

import UIKit

final class SearchCityTableViewController: UITableViewController {
    
    var filteredCities = [City]()
    var itemSelected: ((City) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        edgesForExtendedLayout = []
        tableView.keyboardDismissMode = .onDrag
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell = reusedCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }
        let item = filteredCities[indexPath.row]
        cell.textLabel?.text = item.name
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filteredCities[indexPath.row]
        itemSelected?(item)
    }
}
