//
//  StartScreenViewController.swift
//  AnimalClassifierApp
//
//  Created by Владислав Тихонов on 22.04.2022.
//

import UIKit

class StartScreenViewController: UIViewController {

    @IBOutlet weak var BannerImage: UIImageView!
    
    @IBOutlet weak var BeginButton: UIButton!
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var CreditsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        initButtons()
        initBanner()

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
    BeginButton.imageView?.contentMode = .scaleAspectFit
    BeginButton.setTitle("", for: .normal)
    BeginButton.setBackgroundImage(UIImage(named: NSLocalizedString("btnbegin", comment: "")), for: .normal)

    SettingsButton.imageView?.contentMode = .scaleAspectFit
    SettingsButton.setTitle("", for: .normal)
    SettingsButton.setBackgroundImage(UIImage(named: NSLocalizedString("btnlang", comment: "")), for: .normal)

    CreditsButton.imageView?.contentMode = .scaleAspectFit
    CreditsButton.setTitle("", for: .normal)
    CreditsButton.setBackgroundImage(UIImage(named: NSLocalizedString("btndevinfo", comment: "")), for: .normal)
    
}

func initBanner(){
    BannerImage.image = UIImage(named: NSLocalizedString("banner", comment: ""))
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
