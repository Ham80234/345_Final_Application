

import UIKit


class AboutUs: UIViewController{

    
    
    let CENTERX: CGFloat = UIScreen.main.bounds.size.width / 2.0
    let CENTERY: CGFloat = UIScreen.main.bounds.size.height / 2.0
    
    var animator:  UIDynamicAnimator?
    var d = CGVector(dx: 0.0, dy: 1.0)
    var g = UIGravityBehavior()
     let Name1 = UILabel()
     let Email1 = UILabel()
     let School1 = UILabel()
     let Name2 = UILabel()
     let Email2 = UILabel()
          let School2 = UILabel()

     private var startingPoint: CGPoint = CGPoint(x: 0, y: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = UIColor.white
        
        
        let Back = UIButton()
        Back.setImage(UIImage(named: "Back"), for: UIControl.State.normal)
        Back.frame = CGRect(x: 10, y: 30, width: 50, height: 50)
        Back.isUserInteractionEnabled =  true
        Back.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelDismiss)))
        view.addSubview(Back)
        
        
        
     
        
       
        Name1.text = "Andrew Hamlett"
        Name1.textColor = UIColor.black
        Name1.frame = CGRect(x: CENTERX - 75, y: CENTERY , width: 150, height: 50)
        view.addSubview(Name1)
        Name1.isUserInteractionEnabled = true
        Name1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        
       
        Email1.text = "AHamlett15@winona.edu"
        Email1.textColor = UIColor.black
        Email1.frame = CGRect(x: CENTERX - 125, y: CENTERY + 20, width: 250, height: 50)
        view.addSubview(Email1)
        Email1.isUserInteractionEnabled = true
         Email1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        
       
        School1.text = "Winona Main Campus"
        School1.textColor = UIColor.black
        School1.frame = CGRect(x: CENTERX - 85, y: CENTERY + 40, width: 250, height: 50)
        view.addSubview(School1)
        School1.isUserInteractionEnabled = true
         School1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        
       
        Name2.text = "Jeremiah Jensen"
        Name2.textColor = UIColor.black
        Name2.frame = CGRect(x: CENTERX - 75, y: CENTERY - 75 , width: 150, height: 50)
        view.addSubview(Name2)
        Name2.isUserInteractionEnabled = true
         Name2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        
       
        Email2.text = "jeremiah.jensen@go.winona.edu"
        Email2.textColor = UIColor.black
        Email2.frame = CGRect(x: CENTERX - 125, y: CENTERY - 55, width: 250, height: 50)
        view.addSubview(Email2)
        Email2.isUserInteractionEnabled = true
         Email2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        
  
        School2.text = "Rochester Main Campus"
        School2.textColor = UIColor.black
        School2.frame = CGRect(x: CENTERX - 85, y: CENTERY - 35, width: 250, height: 50)
        view.addSubview(School2)
        School2.isUserInteractionEnabled = true
         School2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        
        
        let Reset = UIButton()
        Reset.frame = CGRect(x: UIScreen.main.bounds.width / 2.0 - 50, y: 100, width: 100, height: 20)
        Reset.backgroundColor = .black
        Reset.setTitle("Fix this ", for: UIControl.State.normal)
        Reset.isUserInteractionEnabled = true
        Reset.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HandleTap)))
        
        view.addSubview(Reset)
        
        let Reset1 = UIButton()
        Reset1.frame = CGRect(x: UIScreen.main.bounds.width / 2.0 - 50, y: 200, width: 100, height: 20)
        Reset1.backgroundColor = .black
        Reset1.setTitle("Gravity", for: UIControl.State.normal)
        Reset1.isUserInteractionEnabled = true
        Reset1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HandleTapGravity)))
        
        view.addSubview(Reset1)
        
   
    
    }
  
    @objc func HandleTap(){
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.5, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            () -> Void in
            self.Name1.frame = CGRect(x: self.CENTERX - 75, y: self.CENTERY , width: 150, height: 50)
            self.Email1.frame = CGRect(x: self.CENTERX - 125, y: self.CENTERY + 20, width: 250, height: 50)
            self.School1.frame = CGRect(x: self.CENTERX - 85, y: self.CENTERY + 40, width: 250, height: 50)
            self.Name2.frame = CGRect(x: self.CENTERX - 75, y: self.CENTERY - 75 , width: 150, height: 50)
            self.Email2.frame = CGRect(x: self.CENTERX - 125, y: self.CENTERY - 55, width: 250, height: 50)
            self.School2.frame = CGRect(x: self.CENTERX - 85, y: self.CENTERY - 35, width: 250, height: 50)
            
        }, completion: {
            (Bool) -> Void in
            
        })
        
    }
    @objc func HandleTapGravity(){
        animator = UIDynamicAnimator(referenceView: self.view)
        
        let g = UIGravityBehavior(items: [Name1, Name2, Email1, Email2, School1, School2])
        
        
        g.gravityDirection = d
        
        let b =  UICollisionBehavior(items: [Name1, Name2, Email1, Email2, School1, School2])
        b.translatesReferenceBoundsIntoBoundary = true
        
        
        let bo = UIDynamicItemBehavior(items: [Name1, Name2, Email1, Email2, School1, School2])
        bo.elasticity = 0.7
        
        
        
        
        
        
        animator?.addBehavior(g)
        animator?.addBehavior(b)
        animator?.addBehavior(bo)
        
        
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        if let view = recognizer.view as? UIButton {
            if recognizer.state == UIGestureRecognizer.State.began {
                startingPoint = recognizer.view!.center
                view.superview?.bringSubviewToFront(recognizer.view!)
            }
            let translation: CGPoint = recognizer.translation(in: self.view)
            let newY = view.center.y + translation.y
            
            view.center = CGPoint(x: view.center.x + translation.x, y: newY)
            recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
            
            if recognizer.state == UIGestureRecognizer.State.ended {
                
                
            }
            if recognizer.state == UIGestureRecognizer.State.cancelled {
                view.center = startingPoint
            }
        }
    }
    
    
    @objc func handelDismiss(){
        self.presentingViewController?.dismiss(animated: true, completion: {() -> Void in
            
        })
    }
}
