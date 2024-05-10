//
//  StandardViews.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-09.
//

import Foundation
import SwiftUI

struct StandardProgressView: View {
    var body: some View {
        ProgressView()
    }
}

struct StandardEmptyView: View {
    private let message: String
    
    init(message: String) {
        self.message = message
    }
    
    var body: some View {
        VStack {
            Text(message)
                .foregroundStyle(.secondary)
        }
    }
}

extension StandardEmptyView {
    init(error: ErrorDisplayable) {
        print(error.localizedDescription)
        self.message = error.localizedDescription
    }
}
