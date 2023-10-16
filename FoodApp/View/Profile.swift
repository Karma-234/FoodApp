//
//  Profile.swift
//  FoodApp
//
//  Created by MAC  on 10/16/23.
//

import SwiftUI

struct Profile: View {
    @Environment(\.presentationMode) var presentation
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastname = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    var body: some View {
        NavigationStack{
            VStack{
                Text("Personal Information")
                Image("profile")
                Text(firstName)
                Text(lastname)
                Text(email)
                Button("Logout"){
                     UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                }
                .padding(.all, 12)
                .frame(maxWidth: .infinity)
                .background(.red)
                .foregroundColor(.white)
                .bold()
                .clipShape(.rect(cornerRadius: 50))
                Spacer()
            }
            .padding(.all, 22)
        }
    }
}

#Preview {
    Profile()
}
