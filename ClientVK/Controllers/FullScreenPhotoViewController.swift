//
//  FullScreenPhotoViewController.swift
//  ClientVK
//
//  Created by Denis Molkov on 14.03.2021.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {

    @IBOutlet weak var photoView: PhotoView!
    
    var photoName: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = photoName {
            photoView.photoName = name
        }
    }
    
}
