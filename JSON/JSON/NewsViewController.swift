//
//  NewsViewController.swift
//  JSON
//
//  Created by Vamshi Padala on 12/20/18.
//  Copyright © 2018 Vamshi Padala. All rights reserved.
//

import UIKit
import Foundation

class NewsViewController: UIViewController {
	
	@IBOutlet weak var newsTableView: UITableView!
	
	// url
	let url = URL(string: "https://newsapi.org/v1/articles?source=the-next-web&sortBy=latest&apiKey=2f98e8fe05a344a3bdd966f65ca550a2")
	
	// model
	var articles = [Article]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// tableView datasource and delegates
		newsTableView.delegate = self
		newsTableView.dataSource = self
		
		// calling requesting json
		requestJSON()
	}
	
	// Rest call to parse json
	func requestJSON() {
		
		guard let newsUrl = url else { return }
		let task = URLSession.shared.dataTask(with: newsUrl) { (data, urlResponse, error) in
			guard let copyData = data else { print("url is not working")
				return }
			do {
				if error == nil {
					let decoder = JSONDecoder()
					let decodedJson = try decoder.decode(News.self, from: copyData)
					
					// append the json
					if let json: [Article] = decodedJson.articles {
						self.articles.append(contentsOf: json)
					}
					DispatchQueue.main.async { self.newsTableView.reloadData() }
					//print(decodedJson)
				}
			} catch let parsingError {
				print(parsingError.localizedDescription)
			}
		}
		task.resume()
	}
	
	// converting string to date
	func convertDate(string: String) -> String {
		
		let dateFormatter = DateFormatter()
		let tempLocale = dateFormatter.locale // save locale temporarily
		dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		let date = dateFormatter.date(from: string)!
		dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
		dateFormatter.locale = tempLocale // reset the locale
		let dateString = dateFormatter.string(from: date)
		
		return dateString
	}
}

// MARK: UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return articles.count
	}
}

// MARK: UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var tableCell = UITableViewCell()
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewsCell {
			
			cell.authorLabel.text = articles[indexPath.row].author
			cell.titleLabel.text =  articles[indexPath.row].title
			cell.descriptionLabel.text = articles[indexPath.row].description
			cell.urlButton.setTitle(articles[indexPath.row].url, for: .normal)
			cell.timeStampLabel.text = "Published At: \(convertDate(string: articles[indexPath.row].publishedAt ?? "someValue")) "
			
			if let imageURL = URL(string: articles[indexPath.row].urlToImage ?? "SomeLink") {
				DispatchQueue.global().async {
					let imageData = try? Data(contentsOf: imageURL)
					if let data = imageData {
						let image = UIImage(data: data)
						DispatchQueue.main.async {
							cell.newsImages.image = image
						}
					}
				}
			}
			
			tableCell = cell
		}
		return tableCell
	}
}
