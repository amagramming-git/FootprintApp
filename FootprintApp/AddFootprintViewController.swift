//
//  ConfirmationViewController.swift
//  FootprintApp
//
//  Created by 神戸悟 on 2019/12/18.
//  Copyright © 2019 SatoruKambe. All rights reserved.
//

import UIKit

class AddFootprintViewController: UIViewController {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
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
    
    //位置情報取得開始時に画面に該当タスクを表示させるためのフラグ
    var taskFlag:Bool?
    var viewController:ViewController?
    
    @IBAction func startButton(_ sender: Any) {
        if self.titleTextField.text != nil && self.finishTimeTextField.text != nil{
            //UserDefaultsにこれから実行するtaskIdをセットする,加え実行フラグを立てる
            let userDefaults = UserDefaults.standard
            var value = userDefaults.integer(forKey: "taskId")
            value = value + 1
            userDefaults.set(value, forKey: "taskId")
            //CoreDataに今回のtaskIdについて保存する
            let f = DateFormatter()
            f.dateFormat = "yyyyMMddHHmmss"
            let startTime = Date()
            let endTime = Calendar.current.date(byAdding: .hour, value: Int(self.finishTimeTextField.text!)!, to: startTime)!
            if let dataController = appDelegate.dataController {
                dataController.saveFootprint(title: self.titleTextField.text!, startTime: f.string(from: startTime), endTime: f.string(from: endTime), taskId: Int32(value))
                taskFlag = true
            }
            //現在の画面を閉じる
            self.dismiss(animated: true, completion:{
                if let viewController = self.viewController{
                    viewController.reloadThis()
                }
            })
        }else{
            //警告文を加える
        }
        
        self.dismiss(animated: true, completion:nil)
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        //キャンセルボタン押下時は何もせず戻る
        self.dismiss(animated: true, completion:nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
