//
//  viewModel.swift
//  menu
//
//  Created by Milo Bello on 9/17/25.
//

import Foundation
import SwiftUI
internal import Combine

class viewModel: ObservableObject {
    @Published var message = "Hello, Single ViewModel!"
    func getText() -> String {
        return "So this is going to be an awesome menu app."
    }
}
