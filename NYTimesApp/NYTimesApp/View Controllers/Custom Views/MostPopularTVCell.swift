//
//  MostPopularTVCell.swift
//  NYTimesApp
//
//  Created by Arvind on 22/06/22.
//

import UIKit

class MostPopularTVCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateButton: UIButton!
    
    // MARK: - Properties
    var mostResult: MostResults? {
        didSet {
            guard let mostResult = mostResult else { return }
            titleLabel.text = mostResult.title
            descriptionLabel.text = mostResult.byline
            authorLabel.text = mostResult.source
            dateButton.setTitle(mostResult.publishedDate, for: .normal)
        }
    }
    
    // MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.accessibilityIdentifier = "titleLabel"
        titleLabel.accessibilityLabel = "Woman Is Fatally Shot While Pushing Baby in Stroller on Upper East Side"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
