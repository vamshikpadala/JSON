//
//  ViewController.swift
//  JSON
//
//  Created by Vamshi Padala on 12/20/18.
//  Copyright © 2018 Vamshi Padala. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
	
	@IBOutlet weak var detailsTableView: UITableView!
	
	// url to request
	let url = URL(string: "http://services.groupkt.com/state/get/USA/all")
	
	// model
	var results = [Result]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//calling request method
		requestJSON()
		
		//tableView
		detailsTableView.rowHeight = UITableView.automaticDimension
		detailsTableView.estimatedRowHeight = 300
		detailsTableView.dataSource = self
		detailsTableView.delegate = self
		detailsTableView.tableFooterView = UIView()
	}
	
	// requesting json from url
	func requestJSON() {
		
		guard let url = url else { return }
		let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
			guard let copyData = data else { print("url is not working")
				return }
			
			do {
				if error == nil {
					let decoder = JSONDecoder()
					let decodedJson = try decoder.decode(RestResponse.self, from: copyData)
					
					// append the json
					if let json: [Result] = decodedJson.result {
						self.results.append(contentsOf: json)
					}
					DispatchQueue.main.async { self.detailsTableView.reloadData() }
				}
			} catch let parsingError  {
				print(parsingError.localizedDescription)
			}
		}
		task.resume()
	}
	
	func formatString() -> String {
		
		let formatter = MeasurementFormatter()
		let distance = Measurement(value: 135767, unit: UnitLength.miles)
		let miles = distance.converted(to: .miles)
		return formatter.string(from: miles)
	}
}

//MARK: TableViewDatasource
extension ViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	// number of rows depending on json data
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return results.count
	}
}

//MARK: TableViewDelegate
extension ViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var tableCell = UITableViewCell()
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DetailsCell {
			
			cell.countryLabel.text = results[indexPath.row].country
			cell.abbrLabel.text = results[indexPath.row].abbr
			cell.areaLabel.text = results[indexPath.row].area
			cell.capitalLabel.text = results[indexPath.row].capital
			cell.largestCityLabel.text = results[indexPath.row].largestCity
			cell.nameLabel.text = results[indexPath.row].name
			
			tableCell = cell
		}
		
		return tableCell
	}
	
}
