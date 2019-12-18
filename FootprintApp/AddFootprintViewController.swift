//
//  AddFootprintViewController.swift
//  FootprintApp
//
//  Created by 神戸悟 on 2019/12/16.
//  Copyright © 2019 SatoruKambe. All rights reserved.
//

import UIKit

class AddFootprintViewController: UIViewController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.delegate = self
    }
    
    //戻るボタンを押した時の処理(正確には画面遷移した時の処理)
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is ViewController {
            let viewController = viewController as! ViewController
            if viewController.statusButton.backgroundColor == UIColor.lightGray{
                viewController.statusButton.backgroundColor = UIColor.blue
            }else{
                viewController.statusButton.backgroundColor = UIColor.lightGray
            }
        }
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
