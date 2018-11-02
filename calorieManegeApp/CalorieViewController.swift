//
//  CalorieViewController.swift
//  calorieManegeApp
//
//  Created by 篠原立樹 on 2018/11/02.
//  Copyright © 2018 Ostrich. All rights reserved.
//

import UIKit

class CalorieViewController: UIViewController {

    var getCalorie: String?
    
    @IBOutlet weak var calorieTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //segueが巻き戻るときの処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === self.saveButton else {
            return
        }
        
        getCalorie = calorieTextField.text
        
    }

}
