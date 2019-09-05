
import UIKit



class GearSubview: UIViewController{
    
    var deligate: DataDelegate?
    
 
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let BlackScreen = UIView()
        let CancelButton = UIButton()
        let ClearButton = UIButton()
        let ClumpButton = UIButton()
        
        
        
        CancelButton.setTitle("Cancel", for: UIControl.State.normal)
        if let window = UIApplication.shared.keyWindow {
            CancelButton.frame = CGRect(x: 0, y: 400, width: window.frame.width, height: 50)
        }
        CancelButton.backgroundColor = UIColor.black
        
        CancelButton.isUserInteractionEnabled = true
        CancelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelDismiss)))
        
        
        
        
        
        ClearButton.setTitle("Clear", for: UIControl.State.normal)
        if let window = UIApplication.shared.keyWindow {
            ClearButton.frame = CGRect(x: 0, y: 200, width: window.frame.width, height: 50)
        }
        ClearButton.backgroundColor = UIColor.black
        
        ClearButton.isUserInteractionEnabled = true
        ClearButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelClear)))
        
        
        
        ClumpButton.setTitle("Clump", for: UIControl.State.normal)
        if let window = UIApplication.shared.keyWindow {
            ClumpButton.frame = CGRect(x: 0, y: 300, width: window.frame.width, height: 50)
        }
        ClumpButton.backgroundColor = UIColor.black
        
        ClumpButton.isUserInteractionEnabled = true
        ClumpButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClump)))
        
        
        BlackScreen.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        if let window = UIApplication.shared.keyWindow {
            BlackScreen.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
        }
        
        view.addSubview(BlackScreen)
        view.addSubview(CancelButton)
        view.addSubview(ClumpButton)
        view.addSubview(ClearButton)
        
        
        
    }
    
    @objc func handelDismiss(){
        self.presentingViewController?.dismiss(animated: true, completion: {() -> Void in
            
        })
    }
    //let vc: ViewController = ViewController()
    @objc func handelClear() {
        //vc.ClearList()
       
        Cleanup()
    }
    
    @objc func handleClump() {
        //vc.ClumpitUp()
        
        Cleanup()
    }
    
    
    
    func Cleanup(){
        self.presentingViewController?.dismiss(animated: true, completion: {() -> Void in
            
        })
    }

}
