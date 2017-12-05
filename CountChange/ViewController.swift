//
//  ViewController.swift
//  CountChange
//
//  Created by 刘继丹 on 2017/12/5.
//  Copyright © 2017年 liu~dan.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var countView:CountView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        countView = CountView.init(frame: CGRect(x:0,y:0,width:200,height:30))
        countView.center = self.view.center
        countView.configDefault(temp_stockCount: "20", temp_unit: "", temp_text: "10")
        self.view.addSubview(countView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        countView.mCountTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


