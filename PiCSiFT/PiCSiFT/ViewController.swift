//
//  ViewController.swift
//  PiCSiFT
//
//  Created by mr-b1nary on 23/12/20.
//

import UIKit

class ViewController: UIViewController {

    var filteredImage: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    
    
    @IBOutlet var imageToggle: UIButton!
    
    
    @IBAction func onImageToggle(_ sender: UIButton) {
        if imageToggle.isSelected {
            let image = UIImage(named: "sample")!
            imageView.image = image
            imageToggle.isSelected = false
        } else {
        imageView.image = filteredImage
        imageToggle.isSelected = true
        }
        
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageToggle.setTitle("Show Before Image", for: .selected)
        
        let image = UIImage(named: "sample")!
        
        let rgbaImage = RGBAImage(image: image)!
        
        let avgRed = 107
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y   *   rgbaImage.width + x
                
                var pixel = rgbaImage.pixels[index]
                
                let redDelta = Int(pixel.red) - avgRed
               
                var modifier = 1 +  4 * (Double(y) / Double(rgbaImage.height))
                if (Int(pixel.red) < avgRed) {
                    modifier = 1
                }
                
                pixel.red = UInt8(max(min(225,Int(round(Double(avgRed) + modifier * Double(redDelta)))), 0))
                rgbaImage.pixels[index] = pixel
            }
        }
        filteredImage = rgbaImage.toUIImage()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


