//
//  ViewController.swift
//  AnimalClassifier
//
//  Created by Владислав Тихонов on 27.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var BeginButton: UIButton!
    @IBOutlet weak var CreditsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        initButtons()
        
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
    BeginButton.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 20)
    CreditsButton.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 20)

    BeginButton.setTitle("Begin", for: .normal)
    CreditsButton.setTitle("Credits", for: .normal)
    
    BeginButton.setTitleColor(.black, for: .normal)
    CreditsButton.setTitleColor(.black, for: .normal)
    
}


}

