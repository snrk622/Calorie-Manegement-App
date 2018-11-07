//
//  CalorieViewController.swift
//  calorieManegeApp
//
//  Created by 篠原立樹 on 2018/11/02.
//  Copyright © 2018 Ostrich. All rights reserved.
//

import UIKit

class CalorieViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard

    var getCalorie: UInt16?
    var time: String?
    
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
    
    //calorieTextFieldの内容が変わったら
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
        
        func getNowClockString() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let now = Date()
            return formatter.string(from: now)
        }
        
        //getCalorieにcalorieTextFieldのtextを代入
        getCalorie = UInt16(calorieTextField.text ?? "")
        time = getNowClockString()
        
    }
    
    //タップしたらキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
