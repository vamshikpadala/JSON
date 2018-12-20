//
//  Details.swift
//  JSON
//
//  Created by Vamshi Padala on 12/20/18.
//  Copyright © 2018 Vamshi Padala. All rights reserved.
//

import Foundation

// model to get json data
// Rest response
struct RestResponse: Decodable {
	
	let result: [Result]?
	let messages: [String]?
	
	enum CodingKeys: String, CodingKey {
		case result = "result"
		case messages = "messages"
	}
	
	enum RestResponseKeys: String, CodingKey {
		case RestResponse = "RestResponse"
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: RestResponseKeys.self)
		
		let restResponseValues = try? values.nestedContainer(keyedBy: CodingKeys.self, forKey: .RestResponse)
		
		result = try restResponseValues?.decodeIfPresent([Result].self, forKey: .result) ?? nil
		messages = try restResponseValues?.decodeIfPresent([String].self, forKey: .messages) ?? nil
	}
}

// Results json
struct Result: Decodable {
	
	var id: Int?
	var country: String?
	var name: String?
	var abbr: String?
	var area: String?
	var largestCity: String?
	var capital: String?
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case country = "country"
		case name = "name"
		case abbr = "abbr"
		case area = "area"
		case largestCity = "largest_city"
		case capital = "capital"
	}
}
