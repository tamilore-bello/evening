//
//  ContentView.swift
//  evening
//
//  Created by Milo Bello on 9/17/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = QuizViewModel()
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
            }
            Tab("Sets", systemImage: "archivebox") {
                setTabView(viewModel: vm)
            }
            Tab("Settings", systemImage: "gearshape") {
            }
        }
    }
}


struct quizSetView: View {
var quiz: QuizSet

    @State var showingPopover = false
    
    var body: some View {
        List {
            Section(header:
                        VStack {
                Text(quiz.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(quiz.descript)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 25)
                Button("edit set ►") {
                    showingPopover = true
                }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)
                    .popover(isPresented: $showingPopover) {
                        newCardView()
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

struct newCardView: View {
    @State var term: String = ""
    @State var def: String = ""
    var body: some View {
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

struct newSetView: View {
    @ObservedObject var viewModel: QuizViewModel

    @Environment(\.dismiss) private var dismiss
    @State var title: String = ""
    @State var descr: String = ""
    var body: some View {
        Text("Create a New Set").font(.title)
            .fontWeight(.bold).padding(.top, 80)
            .padding(.bottom, 25)
        VStack {
            TextField("Title", text: $title).fontWeight(.bold)
                .font(.title2)
            VStack {
                TextEditor(
                    text: $descr
                )
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
                .padding(.bottom, 20)
            }
        }
        .padding(.leading, 50)
        .padding(.trailing, 50)
        Button(action:  {
            viewModel.addSet(name: title, descript: descr)
            dismiss()
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
    }
}

struct setTabView : View {
    //let helper = viewModel()
    @State var showingPopover = false
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        NavigationStack {
            Section(header: Text("Your Sets")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 40)
                .padding(.top, 50))
            {
                Text(String(viewModel.listOfSets.count)+" Sets")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 40)
                    .padding(.bottom, 20)
            }
            List(viewModel.listOfSets, id: \.name) { quiz in NavigationStack {
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
                showingPopover = true
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
            .popover(isPresented: $showingPopover) {
                newSetView(viewModel: viewModel)
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
