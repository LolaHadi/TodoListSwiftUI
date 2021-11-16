//
//  SwiftUIView.swift
//  FinalToDo
//
//  Created by Lola M on 11/5/21.
//

import SwiftUI

struct AddNewToDoView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @State var title = ""
    @State var info = ""
    @State var done = false
    @State var category: ToDoCategory? = nil
    //    @State var timeStamp = false
    @Environment(\.presentationMode) var presentationMode
    
    
    
    var body: some View {
        NavigationView {
            
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
                                let task = Tasky(context: viewContext)
                                task.title = title
                                task.info = info
                                task.isFavourite = done
                                try viewContext.save()
                                
                            }
                            catch { }
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Save")
                        }
                    }
                }.padding()
            }
            
        }
    }


struct AddNewToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewToDoView()
    }
}
