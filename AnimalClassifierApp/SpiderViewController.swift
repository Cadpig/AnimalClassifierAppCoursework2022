//
//  SpiderViewController.swift
//  AnimalClassifierApp
//
//  Created by Владислав Тихонов on 19.04.2022.
//

import UIKit

class SpiderViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var ProceedButton: UIButton!
    @IBOutlet weak var GalleryButton: UIButton!
    @IBOutlet weak var CameraButton: UIButton!
    
    @IBOutlet weak var HeadLabel: UILabel!
    @IBOutlet weak var InfoLabel: UILabel!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    let model = SpidersClassifier()
    
    @IBAction func PredictSpider(_ sender: Any) {//предсказывает вид паука по фотографии, и вероятность того, что это именно этот вид, и выводит на экран
        ProceedButton.isHidden = true
        guard let pixelBuffer = buffer(from: ImageView.image!) else { return }
        guard let SpidersClassifierOutput = try? model.prediction(image: pixelBuffer) else {
    fatalError("Unexpected runtime error.")
}
        InfoLabel.isHidden = false
        let sortedProbas = SpidersClassifierOutput.classLabelProbs.sorted { $0.1 > $1.1 }
        InfoLabel.text = String(format: NSLocalizedString("spiderPrediction %.1@ %.2@", comment: ""), SpidersClassifierOutput.classLabel, String(Int(Array(sortedProbas)[0].value * 100)))
    }
    
    @IBAction func OpenGallery(_ sender: Any) {//функция, открывающая галерею и позволяющая выбрать фото из галереи
        InfoLabel.isHidden = true
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    @IBAction func OpenCamera(_ sender: Any) {//функция, открывающая камеру и позволяющая выбрать сделанное фото
        InfoLabel.isHidden = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        initLabels()
        initButtons()
        InfoLabel.isHidden = true
        ProceedButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func assignbackground(){//функция, инициализирующая фон
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
        
        GalleryButton.imageView?.contentMode = .scaleAspectFit
        GalleryButton.setTitle("", for: .normal)
        GalleryButton.setBackgroundImage(UIImage(named: NSLocalizedString("btngallery", comment: "")), for: .normal)
        
        CameraButton.imageView?.contentMode = .scaleAspectFit
        CameraButton.setTitle("", for: .normal)
        CameraButton.setBackgroundImage(UIImage(named: NSLocalizedString("btncamera", comment: "")), for: .normal)
        
        ProceedButton.imageView?.contentMode = .scaleAspectFit
        ProceedButton.setTitle("", for: .normal)
        ProceedButton.setBackgroundImage(UIImage(named: NSLocalizedString("btnproceed", comment: "")), for: .normal)
    }
    
    func initLabels(){//функция, инициализирующая лейблы
        HeadLabel.text = NSLocalizedString("spiderPick", comment: "PickSpider")
        HeadLabel.font = UIFont(name: "Noteworthy-Bold", size: 20)
        HeadLabel.textColor = .black
        HeadLabel.lineBreakMode = .byCharWrapping
        HeadLabel.textAlignment = .center
        HeadLabel.numberOfLines = 0
        
        InfoLabel.font = UIFont(name: "Noteworthy-Bold", size: 18)
        InfoLabel.textColor = .black
        InfoLabel.lineBreakMode = .byCharWrapping
        InfoLabel.textAlignment = .center
        InfoLabel.numberOfLines = 0
    }

    
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {//вспомогательная функция для imagepickercontroller
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {//контроллер для выбора изображений
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        ImageView.image = image
        self.dismiss(animated: true, completion: nil)
        ProceedButton.isHidden = false
    }
    
func buffer(from image: UIImage) -> CVPixelBuffer? { //конвертер изображений UIImage в CVPixelBuffer
    let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
    var pixelBuffer : CVPixelBuffer?
    let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
    guard (status == kCVReturnSuccess) else {
        return nil
    }

    CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
    let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

    let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
    let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

    context?.translateBy(x: 0, y: image.size.height)
    context?.scaleBy(x: 1.0, y: -1.0)

    UIGraphicsPushContext(context!)
    image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
    UIGraphicsPopContext()
    CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

    return pixelBuffer
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
