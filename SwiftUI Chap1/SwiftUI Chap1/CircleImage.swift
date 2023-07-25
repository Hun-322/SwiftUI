//
//  CircleImage.swift
//  SwiftUI Chap1
//
//  Created by KSH on 2023/07/25.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("불족발")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 3)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
