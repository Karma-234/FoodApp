//
//  Onboarding.swift
//  FoodApp
//
//  Created by MAC  on 10/15/23.
//
let kFirstName = "kFirstName"
let kLastName = "kLastName"
let kEmail = "kEmail"
let kIsLoggedIn = "kIsLoggedIn"
import SwiftUI

struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var scale = 1.0
    @State var error: Alert?
    @State var isPresented: Bool = false
    @State private var isLoggedIn: Bool = false
    var body: some View {
        NavigationStack{
            VStack( spacing: 16){
                Image("logo")
                Spacer()
                    .frame(height: 24)
                Group{
                    TextField("First name", text: $firstName)
                    TextField("Last name", text: $lastName)
                    TextField("Email", text: $email)
                }
                .padding(.all, 16)
                .background(.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 16))
                .scaleEffect(scale)
                .animation(.easeOut, value: scale)
                Spacer()
                    .frame(height: 24)
                Button("Register"){
                    if firstName.isEmpty {
                       error =  Alert(title: Text("First name is empty"))
                        isPresented = true
                            
                    } else if lastName.isEmpty {
                        
                       error =  Alert(title: Text("Last name is empty"))
                        isPresented = true
                            
                    } else if email.isEmpty {
                        error =  Alert(title: Text("Email is empty"))
                        isPresented = true
                            
                    } else {
                        isPresented = true
                        error =  Alert(title: Text("Registeration successful"),dismissButton: Alert.Button.cancel(Text("OK")){
                            isLoggedIn = true
                        })
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        
                    }
                }
                .alert(isPresented: $isPresented, content: {
                    error ?? Alert(title: Text("Successful"))
                })
                .padding(.all, 12)
                .frame(maxWidth: .infinity)
                .background(Color("PrimaryYellow"))
                .foregroundColor(Color("PrimaryGreen"))
                .bold()
                .clipShape(.rect(cornerRadius: 50))
                
            }
            .onAppear(){
                let checkLogin = UserDefaults.standard.bool(forKey: kIsLoggedIn) 
                if checkLogin {
                    isLoggedIn = true
                }
            }
            .padding(.horizontal, 22)
            .navigationDestination(isPresented: $isLoggedIn){
                Home()
            }
            .navigationBarBackButtonHidden()
        }
        
    }
}

#Preview {
    Onboarding()
}
