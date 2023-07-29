//
//  ContentView.swift
//  Pinch
//
//  Created by Subeen on 2023/07/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    
    // MARK: - FUNCTION
    func resetImageState() {
        return withAnimation(.spring()) {
            // 더블탭하여 확대된 이미지를 움직이고 나서
            // 다시 더블탭하여 축소시킬 때 원 상태로 돌리기
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    // MARK: -  CONTENT
    var body: some View {
        // NaviationView is deprecated. -> Use NavigationStack
        NavigationStack {
            ZStack {
                // MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale)
                // MARK: - 1. TAP GESTURE
                    .onTapGesture(count: 2, perform : {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            withAnimation(.spring()) {
                                imageScale = 1
                            }
                        }
                    })
                
                // MARK: - 2. DRAG GESTURE
                    .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                // Swift는 Drag Gesture를 수행할 때 3가지 유형의 액션 호출.
                                // 1. Update
                                // 2. change
                                // 3. end
                                imageOffset = value.translation
                            }
                        }
                        .onEnded { _ in
                            if imageScale <= 1 {
                                resetImageState()
                            }
                        }
                    )
                
            } //: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation (.linear(duration: 1)) { // do not enter the With Animation here!
                    isAnimating = true
                }
            })
        } //: NAVIGATION
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
