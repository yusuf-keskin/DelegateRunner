//
//  ImageVCViewModel.swift
//  DelegateRunner
//
//  Created by YUSUF KESKİN on 11.04.2024.
//

import UIKit

protocol ImageVCViewModelProtocol : AnyObject {
    var viewModelDelegate : ImageVCViewModelDelegate? { get set }
}

protocol ImageVCViewModelDelegate: AnyObject {
    func getImage(image : UIImage)
}

class ImageVCViewModel : ImageVCViewModelProtocol {
    
    let imageLinkProvider : LinkProviderServiceProtocol
    var viewModelDelegate : ImageVCViewModelDelegate?
    
    init(imageLinkProvider: LinkProviderServiceProtocol) {
        self.imageLinkProvider = imageLinkProvider
        imageLinkProvider.delegate = self
    }
    
    private func getDataFromAPI(imageLink: String) async throws -> UIImage {
        guard let url = URL(string: imageLink) else { throw ViewModelError.urlCreationError }
        
        let session = URLSession.shared
        let (responseData, responseCode) = try await session.data(from: url)
        
        guard
            let statusCode = (responseCode as? HTTPURLResponse)?.statusCode,
            case 200...299 = statusCode else {throw ViewModelError.serverError}
        do {
            guard let image = UIImage(data: responseData) else { throw ViewModelError.dataTypeError }
            return (image)
        } catch let error {
            print(error)
            throw error
        }
    }
}

extension ImageVCViewModel : LinkProviderServiceDelegate {
    
    func getImageLink(imageUrlString: String) {
        Task{
            do {
                let image = try await getDataFromAPI(imageLink: imageUrlString)
                viewModelDelegate?.getImage(image: image)
            } catch let error {
                print(error)
            }
        }
    }
}
