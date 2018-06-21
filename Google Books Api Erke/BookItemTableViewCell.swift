//
//  BookItemTableViewCell.swift
//  Google Books Api Erke
//
//  Created by Yerkegali Abubakirov on 10.10.16.
//  Copyright © 2016 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class BookItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
