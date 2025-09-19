//
//  WishlistView.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 7/27/25.
//

import SwiftUI

struct WishlistView: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 32){
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Log in to view your wishlists")
                        .font(.headline)
                    
                    // this allows the user to look through the app without being authenticated. This is a type of app that doesn't require authentication from the start
                    Text("You can create, view, or edit wishlists once you've logged in")
                        .font(.footnote)
                }
                
                Button {
                    print("Log in")
                    
                } label: {
                    Text("Log in")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 360, height: 44)
                        .background(.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                Spacer() //moves content to the top
                
            }
            .padding()
            .navigationTitle("Wishlists")
        }
    }
}

#Preview {
    WishlistView()
}
