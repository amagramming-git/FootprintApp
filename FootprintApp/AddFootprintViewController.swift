//
//  ConfirmationViewController.swift
//  FootprintApp
//
//  Created by 神戸悟 on 2019/12/18.
//  Copyright © 2019 SatoruKambe. All rights reserved.
//

import UIKit

class AddFootprintViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func titleTextField(_ sender: Any) {
    }
    
    @IBAction func finishTimeTextField(_ sender: Any) {
    }
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBOutlet weak var finishTimeTextField: UITextField!
    
    var titleText:String?
    var finishTimeText:String?
    
    @IBAction func startButton(_ sender: Any) {
        //入力されたデータを取り出して保存する。
        self.dismiss(animated: true, completion:{
            /*
            self.titleText = self.titleTextField.text!
            self.finishTimeText = self.finishTimeTextField.text!
            print(self.titleText)
            print(self.finishTimeText)
            */
            let userDefaults = UserDefaults.standard
            if let value = userDefaults.string(forKey: "taskId"){
                self.titleTextField.text = value
            }

        })
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        //キャンセルボタン押下時は何もせず戻る
        self.dismiss(animated: true, completion:nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
