//
//  ExploreView.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 7/25/25.
// todo: add AIAssistant
// 

import SwiftUI

struct ExploreView: View {
    @State private var showDestinationSearchView = false
    // creating instance of view model
    @StateObject var viewModel = ExploreViewModel(service: ExploreService())
    
    
    var body: some View {
        NavigationStack {
            if showDestinationSearchView {
                DestinationSearchView(show: $showDestinationSearchView, viewModel: viewModel)
            } else {
                ScrollView {
                    // NOTE: I put ScrollView in VStack to make SearchAndFilterBar sticky
                    
                    SearchAndFilterBar(location: $viewModel.searchLocation) // adding search bar to Explore page
                        .onTapGesture {
                            withAnimation(.snappy) {
                                showDestinationSearchView.toggle()
                            }
                        }
                                            
                    // renders the items as they appear
                    LazyVStack(spacing: 32){
                        // we are populating our for each loop with all the listings that are comimg back from our ViewModel
                        ForEach(viewModel.listings) { listing in
                            NavigationLink(value: listing) {
                                // we are injecting each listing into our ListingItemView
                                ListingItemView(listing: listing)
                                    .frame(height: 400)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }

                        }
                    }
                    .padding()
                    
                }
                .navigationDestination(for: Listing.self) { listing in
                    ListingDetailView(listing: listing)
                        .navigationBarBackButtonHidden()
                    
                }
                
            }
            
        }
    }
}

#Preview {
    ExploreView()
}
