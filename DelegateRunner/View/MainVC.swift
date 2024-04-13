//
//  MainVC.swift.swift
//  DelegateRunner
//
//  Created by YUSUF KESKİN on 11.04.2024.
//

import UIKit

final class MainVC: UIViewController {

    private lazy var headerLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Medium", size: 25)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Delegates Runner"
        return label
    }()
    
    private lazy var showImageButton : UIButton = {
        let button = UIButton()
        let config = UIButton.Configuration.bordered()
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "photo.fill.on.rectangle.fill")?
            .withTintColor(UIColor.white)
            .withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Click to see random Image", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addTargets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setGradientBackground()
    }
    
    private func addSubviews() {
        view.addSubview(headerLabel)
        view.addSubview(showImageButton)
    }
    
    override func viewDidLayoutSubviews() {
        headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        showImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showImageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        showImageButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func addTargets() {
        showImageButton.addTarget(self, action: #selector(openImageVC), for: .touchUpInside)
    }
    
    @MainActor
    @objc private func openImageVC() {
        let imageListService = LinkProviderService(listApiEndpoint: IMAGE_INFO_LINK)
        let imageDownloadService = ImageVCViewModel(imageLinkProvider: imageListService)
        let imageVC = ImageVC()
        imageVC.imageDownloadService = imageDownloadService
        present(imageVC, animated: true)
    }
    
    private func setGradientBackground(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.gray.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

