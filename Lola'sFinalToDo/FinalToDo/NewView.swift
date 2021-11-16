import SwiftUI

struct NewView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var tasky: Tasky?
    @State var title = ""
    @State var info = ""
    @State var done = false
    @State var category: ToDoCategory? = nil
    //    @State var timeStamp = false
    @Environment(\.presentationMode) var presentationMode
    
    
    init(tasky: Tasky? = nil) {
        self.tasky = tasky
        _title = State(initialValue: tasky?.title ?? "")
        _info = State(initialValue: tasky?.info ?? "")
        _done = State(initialValue: tasky?.isFavourite ?? false)
        //        _timeStamp = State(initialValue: tasky?.timeStamp ?? nil)
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                VStack {
                    TextField("Task Title", text: $title)
                    TextField("Information About Task", text: $info)
                    HStack {
                        VStack {
                            Text("Mark As Done")
                        }
                        VStack {
                            Toggle(isOn: $done) {}
                        }
                    }
                    
                    VStack {
                        Button {
                            do {
                                if let tasky = tasky {
                                    tasky.title = title
                                    tasky.info = info
                                    tasky.isFavourite = done
                                    try viewContext.save()
                                }
                            }
                            catch { }
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Save Changes")
                        }
                    }
                }.padding()
            }
        }
    }
}


struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        let persistentContainer = CoreDataManager.shared.persistentContainer
        NewView()
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, persistentContainer.viewContext)
    }
}
