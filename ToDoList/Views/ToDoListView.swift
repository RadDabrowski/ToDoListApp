//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Radosław Dąbrowski on 21/05/2023.
//
import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    
    
    init(userId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List(items) {item in
                    ToDoListItemView(item: item)
                        .swipeActions{
                            Button("Delete"){
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    // action
                    viewModel.showingNewItemView = true
                }
                label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView)
            {
                NewItemView(newItemPresented:
                                $viewModel.showingNewItemView)
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "MQS2Ni7rjWhSP00xb2JCMD8Bogq1")
    }
}
