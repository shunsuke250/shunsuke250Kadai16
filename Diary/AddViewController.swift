//
//  addViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2021/08/26.
//

import UIKit



class AddViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectDayLabel: UILabel!
    @IBOutlet weak var navSaveButton: UIBarButtonItem!
    
    var d = Date()
    var d1 = Date()
    var year = String()
    var day = Int()
    var month = String()
    var yearmonth = Date()
    var dc = Int()
    var date = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // test用の日記文書
        textView.text = "ぼくは土曜日にお父さんと魚釣りに行きました。朝の5時に家を出発したので、とても眠たかったです。お母さんは家で留守番です。どこに魚釣りに出かけたのかというと、海です。お父さんが「車で2時間もかかるぞ。」と言っていたけれど、本当に2時間くらい車に乗っていました。海は遠いなと思いました。海に着くと、水がとてもきれいだったので驚きました。大きな魚が釣れるかもしれないと、何だかワクワクしました。"
        
        selectDayLabel.text = ""
        // NavigationBarのタイトルをセット
        self.navigationItem.title = "日記を作成"
        // 保存ボタンの大きさを指定
        self.saveButton.frame = CGRect(x: (self.view.frame.size.width / 2) - 150, y: (self.view.frame.size.height / 2) - 50, width: 300, height: 100)
        // 角丸の程度を指定
        self.saveButton.layer.cornerRadius = 10.0
        // Content自体のInsetsを変更
        saveButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 14, right: 40)
        // text部分の余白を作るのでTitle Insetsを変更
        saveButton.titleEdgeInsets = UIEdgeInsets(top: 7, left: 20, bottom: -7, right: -20)
        // 保存ボタンの初期時は無効化
        self.saveButton.isEnabled = false
        self.navSaveButton.isEnabled = false
        saveButton.backgroundColor = .gray
        view.backgroundColor = UIColor(hex: "eaf8fe")
    }
        
    @IBAction func datePickerAction(_ sender: Any) {
        textView.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy年MM月dd日E曜日"
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy年M月d日(E)"
        
        let formatter1 = DateFormatter()
        
        formatter1.locale = Locale(identifier: "ja_JP")
        formatter1.dateFormat = "yyyy年M月"
        
        
        d = formatter.date(from: formatter.string(from: datePicker.date)) ?? Date()
        d1 = formatter1.date(from: formatter1.string(from: datePicker.date)) ?? Date()
        year = String(formatter.calendar.component(.year, from: d))
        month = String(formatter.calendar.component(.month, from: d))
        day = formatter.calendar.component(.day, from: d)
        dc = formatter.calendar.component(.weekday, from: d)
        yearmonth = formatter1.date(from: formatter1.string(from: datePicker.date)) ?? Date()
        selectDayLabel.text = "\(formatter.string(from: d))"
        
        // datepickerで日付が選択された時だけ保存できるように設定
        if selectDayLabel.text != "" || textView.text != ""{
            navSaveButton.isEnabled = true
            saveButton.isEnabled = true
            saveButton.backgroundColor = UIColor(hex: "c17a31")
            saveButton.setTitleColor(UIColor.white, for: .normal)
        }
        
        date = formatter.standaloneWeekdaySymbols[dc - 1]
        
        
        // datepickerから取得される値の確認
        print("formatter.string(from: d): " + formatter.string(from: d))
        print("formatter1.string(from: d1): " + formatter1.string(from: d1))
        print("month: " + month)
        print("day: " + String(day))
        print("date: " + date)
        print("formatter.string(from: datePicker.date: " + formatter.string(from: datePicker.date))
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
