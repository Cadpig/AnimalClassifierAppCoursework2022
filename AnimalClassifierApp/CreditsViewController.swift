//
//  CreditsViewController.swift
//  AnimalClassifierApp
//
//  Created by Владислав Тихонов on 27.03.2022.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var CreditsLabel: UILabel!
    @IBOutlet weak var BackButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        initLabel()
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
        BackButton.setImage(UIImage(systemName: "arrowshape.turn.up.backward.circle"), for: .normal)
        BackButton.setTitle("", for: .normal)
        BackButton.tintColor = .black
        
    }
    
    func initLabel(){
        CreditsLabel.text = "This application was created by Vladislav Tikhonov, a student of group 351, as a coursework."
        CreditsLabel.font = UIFont(name: "Noteworthy-Bold", size: 30)
        CreditsLabel.textColor = .black
        CreditsLabel.lineBreakMode = .byCharWrapping
        CreditsLabel.textAlignment = .center
        CreditsLabel.numberOfLines = 0
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
