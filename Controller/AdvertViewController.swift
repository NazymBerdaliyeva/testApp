//
//  AdvertViewController.swift
//  testApp
//
//  Created by mac on 12/2/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import JGProgressHUD

class AdvertViewController: UIViewController {

    
    @IBOutlet weak var advertImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var advertId: String?
    var advert: Advert?
    var advertProvider: AdvertProvider?
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        if let id = advertId {
            print("i am here")
            advertProvider = AdvertProvider(advertId: id)
            
            
            }
        NotificationCenter.default.addObserver(self, selector: #selector(getAdvertDetail), name: Notification.Name("advertDetail"), object: nil)
        }
    
    @objc func getAdvertDetail(notif: Notification) {
        if let advert = notif.object as? Advert {
            self.advert = advert
            self.hud.dismiss(animated: true)
            DispatchQueue.main.async {
                self.titleLabel.text = self.advert?.title
                
                let url = URL(string: self.advert!.image)
                
                if let url = url {
                    let data = try? Data(contentsOf: url)
                    if let data = data {
                        self.advertImageView.image = UIImage(data: data)
                    }
                }
                if let params = self.advert?.params{
                    for param in params {
                        let color = param["Цвет"]
                        if let colorr = color {
                            self.colorLabel.text = colorr
                            
                        }
                        let size = param["Размер"]
                        if let sizee = size {
                            self.sizeLabel.text = sizee
                        }
                       
                        
//                        println("employee: \(firstName) \(lastName)")
                    }
                }
                
//                self.colorLabel.text = self.advert?.params[@"Цвет"]
//
                self.descriptionTextView.text = self.advert?.description
            }
            print(advert.title)
        }
    }

}
