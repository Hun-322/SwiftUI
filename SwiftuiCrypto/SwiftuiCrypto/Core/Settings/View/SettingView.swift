//
//  SettingView.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/21/23.
//

import SwiftUI

struct SettingView: View {
    
    let defaultURL = URL(string: "https://www.naver.com")!
    let googleURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let gitHubURL = URL(string: "https://github.com/Hun-322")!
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                URLSection
                coinGeckoSection
                developerSection
                applicationSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("세팅")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    leadingNavBarButton
                }
            }
        }
        
    }
}

#Preview {
    SettingView()
}

extension SettingView {
    
    private var leadingNavBarButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
    
    private var URLSection: some View {
        Section(header: Text("URL")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("김세훈이 제작했습니다. 사용 기술은 Swift UI, MVVM Architecture, Combine, CoreData가 사용 되었습니다.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("네이버 링크", destination: defaultURL)
            Link("구글 링크", destination: googleURL)
        }
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGeckoSection")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data is used in this app comes from a free API from CoinGecko Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("코인게코 링크", destination: coingeckoURL)
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("SwiftUI와 Combine 공부용으로 만든 프로젝트입니다. 오랜만에 재밌게 만든 앱니다. 감사합니다.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("깃허브 링크", destination: gitHubURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("서비스 약관", destination: gitHubURL)
            Link("개인정보 보호 정책", destination: gitHubURL)
            Link("회사 웹사이트", destination: gitHubURL)
            Link("서비스 약관", destination: gitHubURL)
            Link("더 알아보기", destination: gitHubURL)
        }
    }
}
