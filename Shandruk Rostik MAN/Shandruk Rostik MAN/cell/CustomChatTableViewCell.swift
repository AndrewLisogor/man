//
//  CustomChatTableViewCell.swift
//  Shandruk Rostik MAN
//
//  Created by Andrew on 12/5/18.
//  Copyright © 2018 Shandruk. All rights reserved.
//

import UIKit

class CustomChatTableViewCell: UITableViewCell {
  
  @IBOutlet weak var lblMessage: UILabel!
  
  @IBOutlet weak var nameLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    separatorInset = UIEdgeInsets.zero
    preservesSuperviewLayoutMargins = false
    layoutMargins = UIEdgeInsets.zero
    layoutIfNeeded()
    
    // Set the selection style to None.
    selectionStyle = UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
