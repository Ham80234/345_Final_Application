

import UIKit


class ModelViewController: UIViewController {
    let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
    let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height
    
    
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        
        
        let Container: UILabel = UILabel(frame: CGRect(x: ScreenHeight / 2.0 - 200, y: ScreenHeight / 2.0 - 200, width: 400, height: 400))
        Container.backgroundColor = UIColor.white
        
        
        view.addSubview(Container)
      
        
    }
    
    
   
    
}

