//
//  ViewController.swift
//  AnimalClassifier
//
//  Created by Владислав Тихонов on 27.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var BirdButton: UIButton!
    @IBOutlet weak var SpiderButton: UIButton!
    @IBOutlet weak var ButterflyButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var HeadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        initButtons()
        initLabel()
        
        // Do any additional setup after loading the view.
    }
func assignbackground(){
        let background = UIImage(named: "MenuBackground")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

func initButtons(){
    BackButton.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 10)
    BackButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
    BackButton.setTitle(NSLocalizedString("back", comment: ""), for: .normal)
    BackButton.tintColor = .black

    BirdButton.imageView?.contentMode = .scaleAspectFit
    BirdButton.setTitle("", for: .normal)
    BirdButton.setBackgroundImage(UIImage(named: NSLocalizedString("btnbirds", comment: "")), for: .normal)

    SpiderButton.imageView?.contentMode = .scaleAspectFit
    SpiderButton.setTitle("", for: .normal)
    SpiderButton.setBackgroundImage(UIImage(named: NSLocalizedString("btnspiders", comment: "")), for: .normal)

    ButterflyButton.imageView?.contentMode = .scaleAspectFit
    ButterflyButton.setTitle("", for: .normal)
    ButterflyButton.setBackgroundImage(UIImage(named: NSLocalizedString("btnbutterflies", comment: "")), for: .normal)
    
}


func initLabel(){
    HeadLabel.text = NSLocalizedString("menuChooseType", comment: "ChooseType")
    HeadLabel.font = UIFont(name: "Noteworthy-Bold", size: 22)
    HeadLabel.textColor = .black
    HeadLabel.lineBreakMode = .byCharWrapping
    HeadLabel.textAlignment = .center
    HeadLabel.numberOfLines = 0
}


}

