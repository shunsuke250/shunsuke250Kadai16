//
//  EditViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2021/09/27.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var EditdayLabel: UILabel!
    @IBOutlet weak var ContentTextView: UITextView!
    @IBOutlet weak var customToolBar: UIToolbar!
    //ViewControllerから値を受け取る
    var contentText = String()
    var dayLabel = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //iPhone X 以降でToolbarのサイズを変更
        if height > 800.0 && height < 1000.0{
            customToolBar.frame = CGRect(x: 0, y: height * 0.91, width: width, height: height * 0.055)
        }
        
        self.navigationItem.title = "日記を編集"
        view.backgroundColor = UIColor(hex: "eaf8fe")
        ContentTextView.backgroundColor = .white
        EditdayLabel.text = dayLabel
    }
    
    
    // viewWillはviewが生成される前なので、既にlabel.textが切り替わってるように見える
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 受け取った値を代入
        ContentTextView.text = contentText
    }
    
    // 他の部分をタップしてキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.ContentTextView.isFirstResponder) {
            self.ContentTextView.resignFirstResponder()
        }
    }
    
    
}
