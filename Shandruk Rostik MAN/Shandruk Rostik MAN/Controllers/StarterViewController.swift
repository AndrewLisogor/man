//
//  StarterViewController.swift
//  Shandruk Rostik MAN
//
//  Created by Rostik on 12/5/18.
//  Copyright © 2018 Shandruk. All rights reserved.
//

import UIKit


final class StarterViewController: UIViewController {
  
  
  // MARK: - Properties
  var username = ""
  
  @IBOutlet weak var imageOwl: UIImageView!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var enterTheNameLabel: UILabel!
  
  @IBOutlet weak var nameTextField: UITextField!
  
  @IBOutlet weak var starChatButton: UIButton!
  
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "segueOne") {
      let vc = segue.destination as! ViewController
      vc.username = nameTextField.text!
    }
}
}
