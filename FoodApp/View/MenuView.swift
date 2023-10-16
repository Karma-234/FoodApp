//
//  Menu.swift
//  FoodApp
//
//  Created by MAC  on 10/16/23.
//

import SwiftUI

struct MenuView: View {
    let categories: [String] = ["Starters", "Desserts", "Drinks","Specials"]
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText: String = ""
    var body: some View {
        VStack{
            VStack{
                Text("Little Lemon")
                    .font(.custom("MarkaziText-Bold", size: 64))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
                    .foregroundColor(Color("PrimaryYellow"))
                HStack{
                    VStack{
                        Text("Chicago")
                            .font(.custom("MarkaziText-Regular", size: 40))
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundColor(.white)
                        Spacer()
                            .frame(height: 8)
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .font(.custom("Karla-Medium", size: 18))
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundColor(.white)

                    }
                    Spacer()
                    Image("hero")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 171)
                        .clipShape(.rect(cornerRadius: 8))
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
                Spacer()
                    .frame(height: 16)
                
                    TextField("Search menu", text: $searchText)
                         .padding(.all, 12)
                         .background(.gray.opacity(1.0))
                         .border(.black)
                         .clipShape(.rect(cornerRadius: 16))
                         .onTapGesture {
                             
                         }
                

            }
            .padding(.all, 12)
            .background(Color("PrimaryGreen"))
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
//            List{
//                
//            }
            ScrollView(.horizontal){
                HStack(alignment: .center){
                    ForEach(categories){ category in
                        Text(category)
                            .fixedSize()
                            .padding(.all, 12)
                            .background(Color("PrimaryGreen"))
                            .foregroundColor(Color("PrimaryYellow"))
                            .clipShape(.rect(cornerRadius: 8))
                    }
                }
                .padding([.leading], 12)
                
            }
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes:[Dish]) in
                List{
                    ForEach(dishes){ dish in
                        HStack{
                            VStack{
                                Text(dish.title ?? "")
                                Text(dish.price ?? "")
                            }
                            AsyncImage(url: URL(string: dish.image ?? "")){item in
                                item
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(.rect(cornerRadius: 16))
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            }
                            .frame(width: 77, height: 70)
                            .clipShape(.rect(cornerRadius: 8))
                            
                        }
                    }
                }
            }
        }
        .task {
            do{
                try await getMenuData()
            }catch MenuError.errorOccured{
                print("an error orccured")
            }catch MenuError.invalidData{
                print("Invalid data")
            }catch{
                print("Unkown Error")
            }
        }
    }
    func getMenuData() async throws -> Void{
        PersistenceController.shared.clear()
        let url = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let appUrl = URL(string: url)!
        let request = URLRequest(url: appUrl)
        let(data, response) = try await  URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw MenuError.errorOccured }
        do{
            let decoder = JSONDecoder()
        let result = try decoder.decode(MenuList.self, from: data)
            for item in result.menu {
                let newDish = Dish(context: viewContext)
                newDish.image = item.image
                newDish.price = item.price
                newDish.title = item.title
            }
            try? viewContext.save()
        } catch {
            throw MenuError.invalidData
        }
        
    }
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare)),]
    }
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}

enum MenuError: Error {
   case errorOccured
    case invalidData
}

#Preview {
    MenuView()
}
