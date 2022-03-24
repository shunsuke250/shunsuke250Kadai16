//
//  ContainerViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2021/08/26.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet private weak var addButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        
        self.addButton.frame = CGRect(x: (self.view.frame.size.width / 2) - 150, y: (self.view.frame.size.height / 2) - 50, width: 300, height: 100)
        self.addButton.backgroundColor = UIColor(hex: "f9d486")
        
        //角丸の程度を指定
        self.addButton.layer.cornerRadius = 30.0
        
        // NavigationBarのタイトルをセット
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = "戻る"
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        
        
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


