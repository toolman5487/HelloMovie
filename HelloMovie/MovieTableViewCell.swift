//
//  MovieTableViewCell.swift
//  HelloMovie
//
//  Created by Willy Hsu on 2025/1/20.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var release_dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    //@IBOutlet weak var titleLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
