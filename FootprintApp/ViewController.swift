//
//  ViewController.swift
//  FootprintApp
//
//  Created by 神戸悟 on 2019/12/14.
//  Copyright © 2019 SatoruKambe. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,CLLocationManagerDelegate{
    //AppDelegateのインスタンスを取得
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

    //MARK:画面パーツ関係
    
    @IBOutlet weak var footprintTableView: UITableView!
    
    
    @IBAction func addFootprintButton(_ sender: Any) {
        if let addFootprintViewController = addFootprintViewController {
            present(addFootprintViewController, animated: true, completion: nil)
        }
    }
    
    
    
    //画面遷移先のインスタンスを保持
    var addFootprintViewController:AddFootprintViewController?
    //位置情報マネージャー
    var locationManager : CLLocationManager!
    
    
    //画面初期処理
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let dataController = appDelegate.dataController {
            let footprintsfetch = dataController.fetchFootprints()
            for footprint in footprintsfetch{
                self.footprints.append(footprint)
            }
        }
        //足跡追加画面をインスタンス化して属性値に保持する
        addFootprintViewController = storyboard?.instantiateViewController(withIdentifier: "showAddFootprintViewController") as? AddFootprintViewController
        if let addFootprintViewController = self.addFootprintViewController{
            addFootprintViewController.viewController = self
        }
        //位置情報関係の初期処理
        locationManager = CLLocationManager.init() //インスタンス生成
        locationManager.allowsBackgroundLocationUpdates = true // バックグランドモードで使用する場合YESにする必要がある
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 位置情報取得の精度
        locationManager.distanceFilter = 1 // 位置情報取得する間隔、1m単位とする
        locationManager.delegate = self  // CLLocationManagerDelegateプロトコルを実装するクラスを指定する
        //一応状態チェックをして、常に位置情報の許可をしていなければその許可を促す
        let status = CLLocationManager.authorizationStatus()
        checkStatusAndrequestAlwaysAuthorization(status:status)
    }
    
    // MARK: Table View関係
    
    //TableViewのいろいろ
    var footprints: Array<Footprints> = []
    //表示数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return footprints.count
    }
    //表示内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = footprints[indexPath.row].title
        
        return cell
    }
    
    var selectedfootprint:Footprints?
    //セルを押した時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 8. SecondViewControllerに渡す文字列をセット
        selectedfootprint = footprints[indexPath.row]

        // 8. SecondViewControllerへ遷移するSegueを呼び出す
        performSegue(withIdentifier: "showShowFootprintViewController", sender: nil)
    }
    
    //Segueによる画面遷移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showShowFootprintViewController") {
            let secondVC: ShowFootprintViewController = segue.destination as! ShowFootprintViewController

            // 11. SecondViewControllerのtextに選択した文字列を設定する
            secondVC.selectedfootprint = selectedfootprint
        }else if(segue.identifier == "showAddFootprintViewController"){
            //let secondVC: ConfirmationViewController = segue.destination as! ConfirmationViewController
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("ビューが読み込まれたよ")
        //locationServicesEnabledをう使って判定
    }
    
    // MARK: 位置情報関係
    //状態チェックの共通メソッドを分けた。ステータス変更した時と画面を読み込んだ時にとりあえず変更を求めるようにしているけど
    func checkStatusAndrequestAlwaysAuthorization(status: CLAuthorizationStatus){
        if (status == .notDetermined) {
            print("許可、不許可を選択してない")
            // 常に許可するように求める
            locationManager.requestAlwaysAuthorization()
        }
        else if (status == .restricted) {
            print("機能制限している")
            // 常に許可するように求める
            locationManager.requestAlwaysAuthorization()
        }
        else if (status == .denied) {
            print("許可していないぜ");
            // 常に許可するように求める
            locationManager.requestAlwaysAuthorization()
        }
        else if (status == .authorizedWhenInUse) {
            print("このアプリ使用中のみ許可しているぜ");
        }
        else if (status == .authorizedAlways) {
            print("常に許可しているぜ");
        }
    }
    // 位置情報が取得されると呼ばれる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 最新の位置情報を取得 locationsに配列で入っている位置情報の最後が最新となる
        let location : CLLocation = locations.last!;
        //データ永続化を試してみる
        let f = DateFormatter()
        f.dateFormat = "yyyyMMddHHmmss"
        let now = Date()
        let nowInt = Int(f.string(from: now))
        let endTimeInt = Int(UserDefaults.standard.string(forKey: "endTime")!)
        if let nowInt = nowInt{
            if let endTimeInt = endTimeInt{
                if nowInt < endTimeInt{
                    if let dataController = appDelegate.dataController {
                        let value = UserDefaults.standard.integer(forKey: "taskId")
                        dataController.saveLocation(time: f.string(from: now), latitude: location.coordinate.latitude, longitude:           location.coordinate.longitude, taskId: Int32(value))
                        let locations:[Locations] = dataController.fetchLocations()
                        print(locations.count)
                    }
                }else{
                    locationManager.stopUpdatingLocation()
                }
            }
        }
        
    }
    
    // 位置情報の取得に失敗すると呼ばれる
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("位置情報の取得に失敗しました")
    }
    
    //多分ステータスを変更したタイミングで呼ばれるんだと思う。
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkStatusAndrequestAlwaysAuthorization(status:status)
    }
    
}

