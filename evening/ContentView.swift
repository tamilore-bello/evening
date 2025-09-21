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
         let listOfSets = viewModel().exec()
        
        List(listOfSets, id: \.name) { quiz in
            NavigationStack {
                HStack {
                    Text(quiz.name)
                    Spacer()
                    Text(String(quiz.cset.count)+" terms")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
