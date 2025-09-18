//
//  ContentView.swift
//  evening
//
//  Created by Milo Bello on 9/17/25.
//

import SwiftUI

struct ContentView: View {
    let helper = viewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(helper.getText())
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
