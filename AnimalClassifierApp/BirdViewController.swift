//
//  BirdViewController.swift
//  AnimalClassifierApp
//
//  Created by Владислав Тихонов on 27.03.2022.
//

import UIKit

class BirdViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var GalleryButton: UIButton!
    @IBOutlet weak var CameraButton: UIButton!
    @IBOutlet weak var ProceedButton: UIButton!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var HeadLabel: UILabel!
    @IBOutlet weak var InfoLabel: UILabel!
    
    let model = BirdsClassifier()
    
    @IBAction func PredictBird(_ sender: Any) {
        ProceedButton.isHidden = true
        guard let pixelBuffer = buffer(from: ImageView.image!) else { return }
        guard let BirdsClassifierOutput = try? model.prediction(image: pixelBuffer) else {
    fatalError("Unexpected runtime error.")
}
        InfoLabel.isHidden = false
        InfoLabel.text = BirdsClassifierOutput.classLabel
    }
    
    @IBAction func OpenGallery(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    @IBAction func OpenCamera(_ sender: Any) {
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
        initLabel()
        InfoLabel.isHidden = true
        ProceedButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func initLabel(){
        HeadLabel.text = "Pick an image of the bird from the gallery or take a photo with the camera."
        HeadLabel.font = UIFont(name: "Noteworthy-Bold", size: 20)
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
    
func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
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
