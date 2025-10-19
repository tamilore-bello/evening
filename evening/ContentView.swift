import SwiftUI
internal import Combine

// VIEW: PARENT VIEW
struct ContentView: View {
    // QuizViewModel object
    @StateObject private var vm = QuizSetListViewModel()
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                Text("hey") .onAppear {
                    //vm.execdb()
                }
            }
            Tab("Sets", systemImage: "archivebox") {
                // set the "Sets" Tab to the Quiz Set List Viewmodel.
                listOfQuizSetView(viewModel: vm)
            }
            
        
            Tab("Settings", systemImage: "gearshape") {
            }
        }
    }

}

// VIEW: view for the list of all user quizSets
struct listOfQuizSetView : View {
    
    // get the viewModel, and by default hide the
    // newQuizSetView
    @State var showingPopover = false
    @ObservedObject var viewModel: QuizSetListViewModel
    
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
            } .onAppear() {
                viewModel.refreshListOfSets()
            }
            // Display the list of all quizSets
            List(viewModel.listOfSets) { quiz in NavigationStack {
                NavigationLink {
                    quizSetView(viewModel: viewModel, quiz: quiz)
                } label: {
                    HStack {
                        Text(quiz.name)
                        Spacer()
                        // Text(String(quiz.cset.count)+" terms")
                    }
                }
            } }
            // on click show the view for adding a new quizSet
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

// VIEW: view for creating a new quizSet
struct newSetView: View {
    
    // observable objects for the quizSetList
    // and whether the view should be dismissed.
    @ObservedObject var viewModel: QuizSetListViewModel
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
        
        // on click, the quizSet should be added to the list,
        // and this view should be dismissed.
        Button(action:  {
            let quiz = QuizSet(name: title, descript: descr)
            viewModel.addSet(quiz: quiz)
            dismiss()
        })
        {
            Image(systemName: "plus")
                .frame(maxWidth: 200)
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

// VIEW: view a single quizSet
struct quizSetView: View {
    @ObservedObject var viewModel: QuizSetListViewModel
    @StateObject var quiz: QuizSet
    // @State var quiz: QuizSet
    @State var showingPopover = false
    // @StateObject var quiz = QuizSet
    
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
                        newCardView(viewmodel: viewModel, quiz: quiz)
                    }
                    .onAppear {
                        // refresh the list.
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
                        FlashcardView(flashcard: card)
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
    

//    @ObservedObject var viewModel: QuizSetListViewModel

// VIEW: view for adding a new card to a quizSet
struct newCardView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewmodel: QuizSetListViewModel
    @State var term: String = ""
    @State var def: String = ""
    var quiz: QuizSet
    
    var body: some View {
        Text("New Card").font(.title)
            .fontWeight(.bold).padding(.top, 80)
            .padding(.bottom, 25)
        HStack {
            VStack {
                Text("Term")
                TextEditor(
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
            let flashcard = Flashcard(term: term, def: def)
            viewmodel.addFlashcard(quiz: quiz, flashcard: flashcard)
            dismiss()
            
        })
        {
            Image(systemName: "plus")
                .frame(maxWidth: 200)
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

struct FlashcardView: View {
    var flashcard: Flashcard
    var body: some View {
        Text(flashcard.term)
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
