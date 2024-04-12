//
//  LinkProviderService.swift
//  DelegateRunner
//
//  Created by YUSUF KESKİN on 11.04.2024.
//

import Foundation

protocol LinkProviderServiceDelegate: AnyObject {
    func getImageLink(imageUrlString : String) throws
}

protocol LinkProviderServiceProtocol: AnyObject {
    var delegate : LinkProviderServiceDelegate? { get set }
}

final class LinkProviderService: LinkProviderServiceProtocol {
    
    var imageInfoLink : String
    
    weak var delegate : LinkProviderServiceDelegate? {
        didSet {
            Task {
                try? await getDataFromAPI()
            }
        }
    }
    
    init(imageInfoLink: String) {
        self.imageInfoLink = imageInfoLink
    }
    
    private func getDataFromAPI() async throws {
        guard let url = URL(string: imageInfoLink) else { throw ViewModelError.urlCreationError }
        
        let session = URLSession.shared
        let (responseData, responseCode) = try await session.data(from: url)
        
        guard
            let statusCode = (responseCode as? HTTPURLResponse)?.statusCode,
            case 200...299 = statusCode else {throw ViewModelError.serverError}
        do {
            let imageListModels = try JSONDecoder().decode([ImageListModel].self, from: responseData)
            guard let randomImageUrlString = imageListModels.randomElement()?.downloadURL else { throw ViewModelError.dataTypeError}
            try delegate?.getImageLink(imageUrlString: randomImageUrlString)
        } catch let error {
            print(error)
            throw error
        }
    }
}
