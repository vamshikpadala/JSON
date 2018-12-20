//
//  File.swift
//  JSON
//
//  Created by Vamshi Padala on 12/20/18.
//  Copyright © 2018 Vamshi Padala. All rights reserved.
//

import Foundation

// nested model
struct News: Decodable {
	
	let articles: [Article]?
	
	enum CodingKeys: String, CodingKey {
		case articles = "articles"
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		articles = try values.decodeIfPresent([Article].self, forKey: .articles) ?? nil
	}
}

// articles model
struct Article: Decodable {
	
	var author: String?
	var title: String?
	var description: String?
	var url: String?
	var urlToImage: String?
	var publishedAt: String?
	
	enum CodingKeys: String, CodingKey {
		
		case author = "author"
		case title  = "title"
		case description = "description"
		case url = "url"
		case urlToImage = "urlToImage"
		case publishedAt = "publishedAt"
	}
}

struct Others: Decodable {
	var status: String?
	var source: String?
	var sortBy: String?
	
	enum CodingKeys: String, CodingKey {
		case status = "status"
		case source = "source"
		case sortBy = "sortBy"
	}
}
