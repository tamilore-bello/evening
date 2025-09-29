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
        // List Set
        let listOfSets = viewModel().exec()
        
        // Bottom Bar
        TabView {
            Tab("Home", systemImage: "house") {
            }
            Tab("Sets", systemImage: "archivebox") {
                ZStack(alignment:.bottomTrailing){
                    NavigationStack {
                        List(listOfSets, id: \.name) { quiz in NavigationStack {
                            NavigationLink {
                                quizSetView(quiz: quiz)
                            } label: {
                                HStack {
                                    Text(quiz.name)
                                    Spacer()
                                    Text(String(quiz.cset.count)+" terms")
                                }
                            }
                        } }
                        Button {
                        } label: {
                            Image(systemName: "plus")
                                .font(.title.weight(.bold))
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 4, x: 0, y: 4)
                        }
                        .padding()
                    }
                    .navigationTitle("Your Sets")
                }
            }
            Tab("Settings", systemImage: "gearshape") {
            }
        }
    }
}


struct quizSetView: View {
    let quiz : QuizSet
    var body: some View {
        
        List {
            Section(header:
                
                Text(quiz.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    , footer:
                HStack {
                    Text("Description")
                    Spacer()
                    Text(String(quiz.cset.count)+" Terms")
                }
            
            ) {
                ForEach(quiz.cset, id: \.id) { card in
                    HStack {
                        Text(card.term)
                        Spacer()
                        Text(String(card.def))
                    }
                }
            }
            
        }
    }
    
}



#Preview {
    ContentView()
}
