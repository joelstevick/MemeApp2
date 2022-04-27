//
//  MemeCellTableViewCell.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/25/22.
//

import UIKit

class MemeCellTableViewCell: UITableViewCell {

    @IBOutlet weak var toplabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
