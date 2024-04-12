//
//  ImageVC.swift
//  DelegateRunner
//
//  Created by YUSUF KESKİN on 11.04.2024.
//

import UIKit

final class ImageVC: UIViewController {
    
    var imageDownloadService : ImageVCViewModelProtocol? = nil 

    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 4
        imageView.image = UIImage(systemName: "photo.circle")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imageDownloadService?.viewModelDelegate = self
        addSubviews()
    }

    private func addSubviews() {
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
    }
}

extension ImageVC : ImageVCViewModelDelegate {
    func getImage(image: UIImage) {
        DispatchQueue.main.async {[weak self] in
            self?.imageView.image = image
        }
    }
}
