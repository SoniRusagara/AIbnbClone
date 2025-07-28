//
//  ExploreView.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 7/25/25.
//

import SwiftUI

struct ExploreView: View {
    @State private var showDestinationSearchView = false
    
    var body: some View {
        NavigationStack {
            if showDestinationSearchView {
                DestinationSearchView(show: $showDestinationSearchView)
            } else {
                ScrollView {
                    // NOTE: I put ScrollView in VStack to make SearchAndFilterBar sticky
                    
                    SearchAndFilterBar() // adding search bar to Explore page
                        .onTapGesture {
                            withAnimation(.snappy) {
                                showDestinationSearchView.toggle()
                            }
                        }
                                            
                    // renders the items as they appear
                    LazyVStack(spacing: 32){
                        ForEach(0 ... 10, id: \.self) { listing in
                            NavigationLink(value: listing) {
                                ListingItemView()
                                    .frame(height: 400)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }

                        }
                    }
                    .padding()
                    
                }
                .navigationDestination(for: Int.self) { listing in
                    ListingDetailView()
                        .navigationBarBackButtonHidden()
                    
                }
                
            }
            
        }
    }
}

#Preview {
    ExploreView()
}
