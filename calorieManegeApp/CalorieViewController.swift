//
//  CalorieViewController.swift
//  calorieManegeApp
//
//  Created by 篠原立樹 on 2018/11/02.
//  Copyright © 2018 Ostrich. All rights reserved.
//

import UIKit

class CalorieViewController: UIViewController {

    var getCalorie: UInt16?
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var calorieTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //saveButtonを無効にする
        self.saveButton.isEnabled = false
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        //このモーダルを閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func calorieTextFieldChanged(_ sender: Any) {
        //calorieにcalorieTextFieldのtextを代入
        let calorie = self.calorieTextField.text ?? ""
        //calorieが空じゃなかったらsaveButtonを有効にする
        self.saveButton.isEnabled = !calorie.isEmpty
    }
    
    //segueが巻き戻るときの処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === self.saveButton else {
            return
        }
        
        //getCalorieにcalorieTextFieldのtextを代入
        getCalorie = UInt16(calorieTextField.text!)
        
    }
    
    //タップしたらキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
