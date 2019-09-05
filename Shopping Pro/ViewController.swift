

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   
    

    
   
    // Gets the Screen Height and Width USed for placements
    let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
    let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height
    //Used for storing
    let defaults = UserDefaults.standard
    //Used for Panning Function
    private var startingPoint: CGPoint = CGPoint(x: 0, y: 0)
    //THis is the list that is used
    @IBOutlet var items: [ListItem] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let title =  UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        title.text = "Shopping Pro"
        title.textColor = UIColor.white
        title.font = UIFont.systemFont(ofSize: 30)
        
        navigationItem.title = "Shopping Pro"
        navigationItem.titleView = title
        
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(Grocery.self, forCellWithReuseIdentifier: "Cellid")
       
        CheckData()
        BuildBottom()
        
        
        let AddButton  = UIButton()
        AddButton.setImage(UIImage(named: "fab"), for: UIControl.State.normal)
        AddButton.frame = CGRect(x: ScreenWidth - 90 , y: ScreenHeight - 285, width: 75, height: 75)
        AddButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAdd)))
        AddButton.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(_:))))
        
        view.addSubview(AddButton)
        view.bringSubviewToFront(AddButton)
        
       
        
    }
    
    // This is code fot eh Collection View, Collection views Require for a
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "Cellid", for: indexPath) as! Grocery
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemove(_:))))
        
        cell.Item = items[indexPath.item]
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
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
    
    
    
    
    
    @objc func handleRemove(_ recognizer: UITapGestureRecognizer){
        //*****************************************
        //  This is a methode that grabs the index of the selected item and removed it fromthe collection view
        //  it assumes there is an element that is clicked, but since the cell is masked directly to this func
        //  There is actually little chance of a null out, but to be saufe if there isnt a value passed it is handled
        //*****************************************
        let Item: UICollectionViewCell = recognizer.view as! UICollectionViewCell
        var num =  collectionView.indexPath(for: Item) ?? nil
        let Number =  num?.row
        items.remove(at: Number ?? 0)
        collectionView.reloadData()
    }
    
    @objc func PopAboutUS(){
        self.present(AboutUs(), animated: true, completion: {() -> Void in
            print("Modal view controller presented...")
        })
    }
    
    
    func SaveData(){
        defaults.removeObject(forKey: "SavedItems")
        defaults.removeObject(forKey: "SavedDept")
        print("Saving")
        var SItemName: [String] = []
        var SDept: [String] = []
        for item in items {
            SItemName.append(item.ItemName!)
            SDept.append(item.Dept!)
        }
        
       
         defaults.set(SItemName, forKey: "SavedItems")
         defaults.set(SDept, forKey: "SavedDept")
    }
    func CheckData(){
        let CData = defaults.value(forKey: "SavedDept") as? [String] ?? []
        let CItems = defaults.value(forKey: "SavedItems") as? [String] ?? []

        print("Data Gathered")
        if(CData.count > 0){
        for n in 0...CData.count-1 {
            let SItem = ListItem()
            SItem.Dept = CData[n]
            SItem.ItemName = CItems[n]
            items.append(SItem)
        }
        }
        collectionView.reloadData()
        
    }
    func BuildBottom(){
        let Bottom = UIView()
        if let window = UIApplication.shared.keyWindow {
            Bottom.frame = CGRect(x: 0, y: window.frame.height - 200
                , width: window.frame.width, height: 150)
        }
        Bottom.backgroundColor = UIColor(red: 66/255, green: 134/255, blue: 244/255, alpha: 1)
        
        
        let clear = UIButton()
        clear.setImage(UIImage(named: "x"), for: UIControl.State.normal)
        if let window = UIApplication.shared.keyWindow {
            clear.frame = CGRect(x: 0, y: window.frame.height - 200
                , width: 50, height: 50)
        }
        clear.isUserInteractionEnabled = true
        clear.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ClearList)))
        
        let org = UIButton()
        org.setImage(UIImage(named: "Organize "), for: UIControl.State.normal)
        if let window = UIApplication.shared.keyWindow {
            org.frame = CGRect(x: window.frame.width / 2.0 - 25, y: window.frame.height - 200
                , width: 50, height: 50)
        }
        org.isUserInteractionEnabled = true
        org.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ClumpitUp)))
        
        let About = UIButton()
        About.setImage(UIImage(named: "Aboutus"), for: UIControl.State.normal)
        if let window = UIApplication.shared.keyWindow {
            About.frame = CGRect(x: window.frame.width - 50, y: window.frame.height - 200
                , width: 50, height: 50)
        }
        
        About.isUserInteractionEnabled = true
        About.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PopAboutUS)))
        
        view.addSubview(Bottom)
        view.addSubview(clear)
        view.addSubview(org)
        view.addSubview(About)
    }
    
    
    
   
    
    // AddButton function
   
   

    @objc func ClearList(){
        print("Here")
        
        items.removeAll()
        collectionView.reloadData()
    }
    
    
    

    @objc func ClumpitUp (){
        items.sort(by: {$0.Dept! > $1.Dept!})
        collectionView.reloadData()
        }

    
   
    
    @objc func handleAdd () {
        
    var ItemtoAdd = ListItem()
        var Name: String = ""
        var Dept: String = ""
        
        let alert: UIAlertController
            = UIAlertController(title: "Enter Food item", message:
                "Enter Items Name", preferredStyle:
                UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style:
            UIAlertAction.Style.default, handler:
            {(action: UIAlertAction!) -> Void in
                Name = alert.textFields![0].text!
                
               
                //Results = ""
            
               
                let alert: UIAlertController
                    = UIAlertController(title: "Enter Dept", message:
                        "Enter Dept", preferredStyle:
                        UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style:
                    UIAlertAction.Style.default, handler:
                    {(action: UIAlertAction!) -> Void in
                        Dept = alert.textFields![0].text!
                       
                       
                        
                        ItemtoAdd.Dept = Dept
                        ItemtoAdd.ItemName = Name
                        
                       self.items.append(ItemtoAdd)
                       self.SaveData()
                       self.collectionView.reloadData()
                        
                        
                      
                }))
                alert.addTextField(configurationHandler: {(t: UITextField) -> Void in
                    t.placeholder = "Enter Dept name"})
                self.present(alert, animated: true, completion:
                    {() -> Void in
                       
                })
                
        }))
        alert.addTextField(configurationHandler: {(t: UITextField) -> Void in
            t.placeholder = "Enter Food item"})
        
        self.present(alert, animated: true, completion:
            {() -> Void in
            
                
        })
        
        
       
      
        
    }
}





class Grocery: UICollectionViewCell {
    var Item: ListItem? {
        didSet{
            itemTitle.text = Item?.ItemName
            Dept.text = Item?.Dept
            
        }
    }
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpView()
    }
    
    
    let itemTitle:UILabel = {
        let item = UILabel()
        item.text = "Test"
        item.textColor = UIColor.black
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    let Dept:UILabel = {
        let item = UILabel()
        item.text = "Bread"
        item.textColor = UIColor.black
         item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    let Line:UIView = {
        let item = UIView()
        item.backgroundColor = UIColor.black
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    func setUpView(){

        addSubview(itemTitle)
        addSubview(Dept)
        //addSubview(Line)
        

        AddConstrant(format: "H:|-16-[v0]-100-[v1]-16-|", view: itemTitle, Dept)
        AddConstrant(format: "V:|-16-[v0]-16-|", view: itemTitle, Line)
        AddConstrant(format: "V:|-16-[v0]-16-|", view: Dept)


        
        

        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView{
    func AddConstrant(format: String, view: UIView...){
        var viewDict: [String: UIView] = [:]
        for(index, view) in view.enumerated(){
           
            let key = "v\(index)"
            viewDict[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDict))
    }
}
