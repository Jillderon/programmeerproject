//
//  ReviewResultsEmployeeCell.swift
//  JasperScholten-project
//
//  Created by Jasper Scholten on 12-01-17.
//  Copyright © 2017 Jasper Scholten. All rights reserved.
//

import UIKit

class ReviewResultsEmployeeCell: UITableViewCell {

    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var reviewResult: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
