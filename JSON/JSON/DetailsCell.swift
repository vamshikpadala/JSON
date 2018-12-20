//
//  DetailsCell.swift
//  JSON
//
//  Created by Vamshi Padala on 12/20/18.
//  Copyright © 2018 Vamshi Padala. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {
	
	@IBOutlet weak var countryLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var areaLabel: UILabel!
	@IBOutlet weak var largestCityLabel: UILabel!
	@IBOutlet weak var capitalLabel: UILabel!
	@IBOutlet weak var abbrLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
