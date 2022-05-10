//
//  LanguageViewController.swift
//  AnimalClassifierApp
//
//  Created by Владислав Тихонов on 27.04.2022.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var EnglishButton: UIButton!
    @IBOutlet weak var RussianButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var HeadLabel: UILabel!
    
    @IBAction func ChangeToEnglish(_ sender: Any) {
        let lang = "en"
        let defaults = UserDefaults.standard
        defaults.set([lang], forKey: "AppleLanguages")
        defaults.synchronize()
        Bundle.setLanguage(lang)
    }
    
    @IBAction func ChangeToRussian(_ sender: Any) {
        let lang = "ru"
        let defaults = UserDefaults.standard
        defaults.set([lang], forKey: "AppleLanguages")
        defaults.synchronize()
        Bundle.setLanguage(lang)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        initButtons()
        initLabel()
        // Do any additional setup after loading the view.
    }
    
    func initLabel(){
        HeadLabel.text = NSLocalizedString("languageChange", comment: "")
        HeadLabel.font = UIFont(name: "Noteworthy-Bold", size: 22)
        HeadLabel.textColor = .black
        HeadLabel.lineBreakMode = .byCharWrapping
        HeadLabel.textAlignment = .center
        HeadLabel.numberOfLines = 0
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
    
    func initButtons(){//функция, инициализирующая кнопки
        BackButton.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 10)
        BackButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        BackButton.setTitle(NSLocalizedString("back", comment: ""), for: .normal)
        BackButton.tintColor = .black
        
        EnglishButton.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 50)
        EnglishButton.imageView?.contentMode = .scaleAspectFit
        EnglishButton.setTitle("🇺🇸", for: .normal)
        EnglishButton.setBackgroundImage(UIImage(named: "round"), for: .normal)
        
        RussianButton.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 50)
        RussianButton.imageView?.contentMode = .scaleAspectFit
        RussianButton.setTitle("🇷🇺", for: .normal)
        RussianButton.setBackgroundImage(UIImage(named: "round"), for: .normal)
        
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
