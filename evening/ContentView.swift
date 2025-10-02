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
                NavigationStack {
                    Section(header: Text("Your Sets")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 40)
                        .padding(.top, 50))
                    {
                        Text(String(listOfSets.count)+" Sets")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 40)
                            .padding(.bottom, 20)
                    }
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
                    
                    Button(action:  {
                        // action here:???
                    })
                    {
                        Image(systemName: "plus")
                            .frame(maxWidth: .infinity) // Apply to the label
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.title.weight(.medium))
                            .cornerRadius(20)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            }
            Tab("Settings", systemImage: "gearshape") {
            }
        }
    }
}


struct quizSetView: View {
    let quiz : QuizSet
    @State var showingPopover = false
    @State var term: String = ""
    @State var def: String = ""
    
    var body: some View {
        List {
            Section(header:
                        VStack {
                Text(quiz.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(quiz.descript)
                
                
                Button("edit set ►") {
                    showingPopover = true
                }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)
                    .popover(isPresented: $showingPopover) {
                        Text("New Card").font(.title)
                            .fontWeight(.bold).padding(.top, 80)
                            .padding(.bottom, 25)
                        HStack {
                            VStack {
                                Text("Term")
                                TextEditor(
                                    //"Term",
                                    text: $term
                                )
                                .padding()
                                .frame(maxHeight: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                            }
                            VStack {
                                Text("Definition")
                                TextEditor(
                                    //"Definition",
                                    text: $def
                                )
                                .padding()
                                .frame(maxHeight: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                            }
                        }
                        .padding(.leading, 50)
                        .padding(.trailing, 50)
                        Button(action:  {
                            // action here:???
                        })
                        {
                            Image(systemName: "plus")
                                .frame(maxWidth: 200) // Apply to the label
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .font(.title.weight(.medium))
                                .cornerRadius(20)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        VStack {
                            Button("Delete Set") {}.frame(alignment: .trailing)
                            Button("Rename Set") {}
                                .frame(alignment: .trailing)
                            Button("Edit Description") {}
                                .frame(alignment: .trailing)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                
                
            }
                    , footer:
                HStack {
                    Text("Description")
                    Spacer()
                    Text(String(quiz.cset.count)+" Terms")
                }
            
            ) {
                ForEach(quiz.cset, id: \.id) { card in
                    NavigationLink {
                        FlashcardView()
                    } label : {
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
    
}

struct FlashcardView: View {
    var body: some View {
        
        Text("Flashcard")
    }
}

struct editFlashcardView: View {
    var body: some View {
        
        Text("Flashcard")
    }
}
#Preview {
    ContentView()
}
