import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Tasky.entity(), sortDescriptors: [NSSortDescriptor(key: "timeStamp", ascending: false)], animation: .default)
    
    private var myTasky: FetchedResults<Tasky>
    @State var title: String = ""
    @State var info: String = ""
    @State var isFavourite: Bool = false
    @State var timeStamp = Date()
    
    @State var isShowingAddNewToDoView = false
    
    var body: some View {
        
        NavigationView {
            
            List {
                if myTasky.isEmpty {
                    Text("List is Empty")
                } else {
                    ForEach(myTasky) { tasky in
                        
                        NavigationLink(destination: {
                            NewView(tasky: tasky)
                        }, label: {
                            // I may insert sections, each section for a specific category.
                            HStack {
                                VStack {
                                    Button {
                                        tasky.isFavourite.toggle()
                                        do {
                                            try viewContext.save()
                                        } catch {
                                            
                                        }
                                    } label: {
                                        Image(systemName: tasky.isFavourite ? "checkmark" : "" )
                                    }.buttonStyle(.borderless)
                                }
                                
                                VStack {
                                    Text(tasky.title ?? "")
                                }
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button {
                                    if let deletedTasky = myTasky.firstIndex(of: tasky) {
                                        viewContext.delete(myTasky[deletedTasky])
                                        do {
                                            try viewContext.save()
                                        } catch {
                                            
                                        }
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }.tint(.red)
                            }
                            
                        }
                        )}
                }
            }.fullScreenCover(isPresented: $isShowingAddNewToDoView, content: {
                AddNewToDoView()
            }).navigationTitle("List of Tasks").padding()
                .navigationBarItems(trailing:
                                        Button("Add New") {
                    isShowingAddNewToDoView = true
                })
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistentContainer = CoreDataManager.shared.persistentContainer
        ContentView()
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, persistentContainer.viewContext)
    }
}
