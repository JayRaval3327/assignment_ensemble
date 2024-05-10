//
//  ErrorDisplayable.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-09.
//

import Foundation
import SwiftUI

public struct ErrorDisplayable: LocalizedError {
    let localizedDescription: String
    let localizedTitle: String?
    let image: Image?

    init(localizedDescription: String, localizedTitle: String? = nil, image: Image? = nil) {
        self.localizedDescription = localizedDescription
        self.localizedTitle = localizedTitle
        self.image = image
    }

}

extension ErrorDisplayable {
    
    private enum Labels {
        static let somethingWentWrong = "Something Went Wrong!"
    }
    
    init(_ error: Error) {
        if let displayable = error as? ErrorDisplayable {
            self.init(localizedDescription: displayable.localizedDescription,
                      localizedTitle: displayable.localizedTitle,
                      image: displayable.image)
        } else if let networkError = error as? NetworkError {
            self.init(localizedDescription: networkError.errorDescription ?? Labels.somethingWentWrong)
        } else {
            self.init(localizedDescription: error.localizedDescription)
        }
    }
}
