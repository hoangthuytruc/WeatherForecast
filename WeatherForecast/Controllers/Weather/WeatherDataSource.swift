//
//  WeatherDataSource.swift
//  WeatherForecast
//
//  Created by httruc on 8/8/24.
//

import UIKit

final class WeatherDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var items = [QueryWeatherResponse]()
    
    var didSelectItemAt: (QueryWeatherResponse) -> Void = { _ in }
    var didDeleteRowAt: (Int) -> Void = { _ in }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            as? WeatherCell else {
            return UITableViewCell()
        }
        cell.configureCell(items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItemAt(items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            didDeleteRowAt(indexPath.row)
        }
    }
}
