//
//  NewsCell.swift
//  ADT News
//
//  Created by Vamshi Padala on 12/18/18.
//

import UIKit
import SafariServices

class NewsCell: UITableViewCell {
	
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var urlButton: UIButton!
	@IBOutlet weak var newsImages: UIImageView!
	@IBOutlet weak var timeStampLabel: UILabel!
	
	var articles = [Article]()
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		descriptionLabel.sizeToFit()
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	@IBAction func urlAction(_ sender: Any) {
		
		if let url = URL(string: urlButton.titleLabel?.text ?? "someUrl") {
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		}
	}

}
