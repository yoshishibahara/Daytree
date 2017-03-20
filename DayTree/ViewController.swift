//
//  ViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/02/10.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var fruits = ["Apple", "Orange", "Grape"]
    
    @IBOutlet var dateTableView: UITableView!
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    // section毎の画像配列
    var imgArray: [String] = ["img0.jpg"]
    
    var entryArray = [[Any]]()
    
    var dateArray: [String] = ["↑First Day↑"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dateTableView.delegate = self
        dateTableView.dataSource = self
        
        entryArray.append(["0320","SpringCamp"])
    }

    

    //addButtonが押された際呼び出される
   @IBAction func addCell(sender: AnyObject) {
        print("追加")
    
    //textの表示はalertのみ。ActionSheetだとtextfiledを表示させようとすると
    //落ちます。
    let alert:UIAlertController = UIAlertController(title:"Entry",
                                                    message: "What happened today?",
                                                    preferredStyle: UIAlertControllerStyle.alert)
    
    let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                   style: UIAlertActionStyle.cancel,
                                                   handler:{
                                                    (action:UIAlertAction!) -> Void in
                                                    print("Cancel")
    })
    let defaultAction:UIAlertAction = UIAlertAction(title: "Save",
                                                    style: UIAlertActionStyle.default,
                                                    handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("Save")
                                                        
                                                        let dataText = alert.textFields![0].text! as String
                                                        let contentText = alert.textFields![1].text! as String
                                                            
                                                        self.entryArray.append([dataText,contentText])
                                                        
//                                                        let textFields:Array<UITextField>? =  alert.textFields?[0] as Array<UITextField>?
//                                                        if textFields != nil {
//                                                            for textField:UITextField in textField.Array {
//                                                                
//                                                                self.entryArray.append(textField.text!)
//                                                                self.imgArray.append("img0.jpg")
//                                                                
                                                                // TableViewを再読み込み.
                                                                self.dateTableView.reloadData()
//
//                                                                //各textにアクセス
//                                                                print(textField.text)
//                                                            }
//                                                        }

    })
                                                        
    alert.addAction(cancelAction)
    alert.addAction(defaultAction)

    alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
        //対象UITextFieldが引数として取得できる
        text.placeholder = "Date"
    })
    alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
        text.placeholder = "What happened?"
        
    })

//    //textfieldの追加
//    alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
//    })
//    //実行した分textfieldを追加される。
//    alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
//    })
    present(alert, animated: true, completion: nil)
    
//    alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
//        //対象UITextFieldが引数として取得できる
//        text.placeholder = "Date"
//    })
//    alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
//        text.placeholder = "What happened?"
//        
//    })
    
//        // myItemsに追加.
//        imgArray.append("img0.jpg")
//        entryArray.append("2017/03/19")
    
        // TableViewを再読み込み.
        dateTableView.reloadData()
    }
    
    
    //Cellを挿入または削除しようとした際に呼び出される
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // 削除のとき
        if editingStyle == .delete {
            entryArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            dateTableView.reloadData()
            
            print("Delete")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryArray.count
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        // セルに表示する値を設定する
       // cell.textLabel!.text = fruits[indexPath.row]
        
    

//            img = UIImage(named:"\(imgArray[indexPath.row])")
        let img = UIImage(named:"img1.jpg")
        // Tag番号 1 で UIImageView インスタンスの生成
        let imageView = dateTableView.viewWithTag(1) as! UIImageView
        imageView.image = img
        
        // Tag番号 ２ で UILabel インスタンスの生成
        let label1 = dateTableView.viewWithTag(2) as! UILabel
        label1.text = "\(entryArray[indexPath.row][0])"
        
        // Tag番号 ３ で UILabel インスタンスの生成
        let entry = dateTableView.viewWithTag(3) as! UILabel
        entry.text = "\(entryArray[indexPath.row][1])"
        
        return cell
    }
    
    /// セルが選択された時に呼ばれるデリゲートメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セル番号：\(entryArray[indexPath.row][0]) セルの内容：\(entryArray[indexPath.row][1]) ")
    }


}

