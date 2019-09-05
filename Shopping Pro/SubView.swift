//
//  AddItem.launcher.swift
//  Shopping Pro
//
//  Created by Hamlett, Andrew W on 4/25/19.
//  Copyright © 2019 Hamlett, Andrew W. All rights reserved.
//

import UIKit

let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height

let Disire = ScreenHeight / 2.0 - 150

class SubView: NSObject {
    
    
    let BlackScreen = UIView()
    
    let AddView: UIView = {
        let viewable =  UIView(frame: CGRect(x: ScreenWidth / 2.0 - 150, y: -300, width: 300, height: 300))
        viewable.backgroundColor = UIColor.white
       
        
        let Vx = viewable.center.x
        let Vy =  viewable.center.y
        
        let ItemTextField: UITextField = UITextField()
        
        ItemTextField.frame = CGRect(x: Vx - (viewable.frame.width / 2.0) - 57, y: Vy + 190, width: viewable.frame.width, height: 50)
        ItemTextField.textColor = UIColor.black
        ItemTextField.font = UIFont.systemFont(ofSize: 24.0)
        ItemTextField.placeholder = "Enter Item"
        ItemTextField.backgroundColor = UIColor.white
        ItemTextField.keyboardType = UIKeyboardType.default
        ItemTextField.returnKeyType = UIReturnKeyType.done
        ItemTextField.clearButtonMode = UITextField.ViewMode.always
        ItemTextField.layer.borderColor = UIColor.black.cgColor
        ItemTextField.borderStyle = UITextField.BorderStyle.line
        ItemTextField.layer.borderWidth = 1
        //.delegate = self
        viewable.addSubview(ItemTextField)
        
        let Item = ItemTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
       
        
        
        let DeptTestFeield: UITextField = UITextField()
        
        DeptTestFeield.frame = CGRect(x: Vx - (viewable.frame.width / 2.0) - 57, y: Vy + 260, width: viewable.frame.width, height: 50)
        DeptTestFeield.textColor = UIColor.black
        DeptTestFeield.font = UIFont.systemFont(ofSize: 24.0)
        DeptTestFeield.placeholder = "Enter Dept"
        DeptTestFeield.backgroundColor = UIColor.white
        DeptTestFeield.keyboardType = UIKeyboardType.default
        DeptTestFeield.returnKeyType = UIReturnKeyType.done
        DeptTestFeield.clearButtonMode = UITextField.ViewMode.always
        DeptTestFeield.layer.borderColor = UIColor.black.cgColor
        DeptTestFeield.borderStyle = UITextField.BorderStyle.line
        DeptTestFeield.layer.borderWidth = 1
        //.delegate = self
        viewable.addSubview(DeptTestFeield)
        
        let Dept = DeptTestFeield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let AddButton = UILabel()
        AddButton.textColor = UIColor.white
        AddButton.text = "Add Item"
        
   
        
        var Itemtoadd = ListItem()
        Itemtoadd.Dept = Dept
        Itemtoadd.ItemName = Item
        
        
        AddButton.backgroundColor = UIColor(red: 66/255, green: 134/255, blue: 244/255, alpha: 1)
        AddButton.frame = CGRect(x: Vx - (viewable.frame.width / 2.0) - 57, y: Vy + 325, width: viewable.frame.width, height: 50)
        AddButton.textAlignment = NSTextAlignment.center
        
       
        
        let CancelButton = UILabel()
        CancelButton.textColor = UIColor.white
        CancelButton.text = "Cancel"
        CancelButton.textAlignment = NSTextAlignment.center
        CancelButton.backgroundColor = UIColor(red: 66/255, green: 134/255, blue: 244/255, alpha: 1)
        CancelButton.frame = CGRect(x: Vx - (viewable.frame.width / 2.0) - 57, y: Vy + 385, width: viewable.frame.width, height: 50)
        CancelButton.isUserInteractionEnabled = true
        CancelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
  
      
        
        viewable.addSubview(AddButton)
        viewable.addSubview(CancelButton)
        
      
        return viewable
    }()
    
    func ShowAddItem() {
        if let window = UIApplication.shared.keyWindow {
            
            BlackScreen.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            BlackScreen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(BlackScreen)
            window.addSubview(AddView)
            BlackScreen.frame = window.frame
            BlackScreen.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.BlackScreen.alpha = 1
                self.AddView.frame = CGRect(x: ScreenWidth / 2.0 - 150, y: ScreenHeight / 2.0 - 150, width: 300, height: 300)
            })
            
            
        }
        
    }
    
    

    @objc func handleDismiss () {
        print("is this working")
        UIView.animate(withDuration: 0.5) {
            self.BlackScreen.alpha = 0
            self.AddView.frame =  CGRect(x: ScreenWidth / 2.0 - 150, y: -300, width: 300, height: 300)
        }
    }
    
   
    

    
    override init() {
        super.init()
    }
    
}
