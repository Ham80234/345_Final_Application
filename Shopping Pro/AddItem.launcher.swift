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

class Additem: NSObject {
    
    
    let BlackScreen = UIView()
    
    let AddView: UIView = {
        let viewable =  UIView(frame: CGRect(x: ScreenWidth / 2.0 - 150, y: -300, width: 300, height: 300))
        viewable.backgroundColor = UIColor.white
        
   
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
        UIView.animate(withDuration: 0.5) {
            self.BlackScreen.alpha = 0
            self.AddView.frame =  CGRect(x: ScreenWidth / 2.0 - 150, y: -300, width: 300, height: 300)
            
            
        }
    }
    @objc func AddItem (item: String ) {
     
        print(item)
    }
   
    override init() {
        super.init()
    }

}
