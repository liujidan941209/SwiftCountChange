//
//  CountView.swift
//  CountChange
//
//  Created by 刘继丹 on 2017/12/5.
//  Copyright © 2017年 liu~dan.com. All rights reserved.
//

import Foundation
import UIKit

class CountView: UIView {
    
    var mAddbtn: UIButton!
    var mSubtractBtn: UIButton!
    var mFirstLine: UIView!
    var mSecondLine: UIView!
    var mCountTextField: UITextField!
    
    var stockCount:String = "10"//最大库存个数
    var unit:String!//单位
    var textStr: String!//数量变化值

    typealias tempBlock = (_ count: String) ->()
    var countChangeBlock:tempBlock!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(frame: CGRect) {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        
        let center_width = frame.width/3+10
        let other_width = (frame.width - center_width)/2
        
        //增加
        mAddbtn = UIButton.init(frame: CGRect.init(x: frame.width - other_width, y: 0, width: other_width, height: frame.height))
        mAddbtn.setImage(UIImage.init(named: "ico_plus"), for: UIControlState.normal);
        mAddbtn.addTarget(self, action: #selector(addBtnClick), for: UIControlEvents.touchUpInside)
        self.addSubview(mAddbtn)
        
        //减少
        mSubtractBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: other_width, height: frame.height))
        mSubtractBtn.setImage(UIImage.init(named: "ico_minus2"), for: UIControlState.normal)
        mSubtractBtn.addTarget(self, action: #selector(subtractBtnClick), for: UIControlEvents.touchUpInside)
        self.addSubview(mSubtractBtn)
        
        //数值
        mCountTextField = UITextField.init(frame: CGRect.init(x: other_width, y: 0, width: center_width, height: frame.height))
        mCountTextField.textColor = UIColor.black
        mCountTextField.font = UIFont.systemFont(ofSize: 12)
        mCountTextField.tintColor = UIColor.red
        mCountTextField.keyboardType = UIKeyboardType.numberPad
        mCountTextField.textAlignment = NSTextAlignment.center
        mCountTextField.addTarget(self, action: #selector(countEnd), for: UIControlEvents.editingDidEnd)
        self.addSubview(mCountTextField)
        
        //分隔线
        mFirstLine = UIView.init(frame: CGRect.init(x: other_width, y: 0, width: 0.5, height: frame.height))
        mFirstLine.backgroundColor = UIColor.lightGray
        self.addSubview(mFirstLine)
        mSecondLine = UIView.init(frame: CGRect.init(x: frame.width - other_width-0.5, y: 0, width: 0.5, height: frame.height))
        mSecondLine.backgroundColor = UIColor.lightGray
        self.addSubview(mSecondLine)
        
    }
    
    //设置默认值
    func configDefault(temp_stockCount:String,temp_unit:String,temp_text:String) {
        
        unit = temp_unit
        stockCount = temp_stockCount
        textStr = temp_text
        
        if unit.description.count != 0
        {
            mCountTextField.text = textStr + unit
        } else {
            mCountTextField.text = textStr
        }
        
        if Int(textStr) == 1 {
            mSubtractBtn.setImage(UIImage.init(named: "ico_minusgray"), for: UIControlState.normal)
        } else {
            mSubtractBtn.setImage(UIImage.init(named: "ico_minus2"), for: UIControlState.normal)
        }
        
    }
    
    //增加函数
    @objc func addBtnClick() {
        
        let count = Int(textStr!)! + 1
        mSubtractBtn.setImage(UIImage.init(named: "ico_minus2"), for: UIControlState.normal)
        
        if (count > Int(stockCount)!) {
            
            let alterView = UIAlertView.init(title: "提示", message:  "不能再多了哦～", delegate: self, cancelButtonTitle: "知道了")
            alterView.show()

            textStr = stockCount
            if unit.description.count != 0 {
                mCountTextField.text = textStr + unit
            } else {
                mCountTextField.text = textStr
            }
            
        } else {
            
            textStr = String(format: "%d",count)
            if unit.description.count != 0  {
                mCountTextField.text = textStr + unit
            } else {
                mCountTextField.text = textStr
            }
            
            if let _ = countChangeBlock {
                countChangeBlock(textStr)
            }
            
        }
        
    }
    
    //减少函数
    @objc func subtractBtnClick() {
        
        let count = Int(textStr!)! - 1
        
        if (count < 1) {
            
            let alterView = UIAlertView.init(title: "提示", message:  "不能再少了哦～", delegate: self, cancelButtonTitle: "知道了")
            alterView.show()
            mSubtractBtn.setImage(UIImage.init(named: "ico_minusgray"), for: UIControlState.normal)
            
        } else {
            
            textStr = String(format: "%d",count)
            if unit.description.count != 0  {
                mCountTextField.text = textStr + unit
            } else {
                mCountTextField.text = textStr
            }
            mSubtractBtn.setImage(UIImage.init(named: "ico_minus2"), for: UIControlState.normal)
            if let _ = countChangeBlock {
                countChangeBlock(textStr)
            }
            
        }
        
    }
    
    @objc func countEnd(textField: UITextField) {
        
        var count = 0
        if (textField.text?.description.count != 0) {
            textStr = textField.text
            count = Int(textStr!)!
        }
        
        if textField.text == nil || (textField.text! as NSString).intValue == 0 {
            let alterView = UIAlertView.init(title: "提示", message:  "不能再少了哦～", delegate: self, cancelButtonTitle: "知道了")
            alterView.show()
            textStr = "1"
            mCountTextField.text = textStr
        }
        
        if count > Int(stockCount)! {
            let alterView = UIAlertView.init(title: "提示", message:  "不能再多了哦～", delegate: self, cancelButtonTitle: "知道了")
            alterView.show()
            textStr = stockCount
            if unit.description.count != 0  {
                mCountTextField.text = textStr + unit
            } else {
                mCountTextField.text = textStr
            }
        }
        
        if let _ = countChangeBlock {
            countChangeBlock(textStr!)
        }
        
    }
}
