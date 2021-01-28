//
//  JokeCellTableViewCell.swift
//  AGChuckNorris
//
//  Created by iMac on 28.01.2021.
//  Copyright © 2021 AlexGermek. All rights reserved.
//

import UIKit

class JokeCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
