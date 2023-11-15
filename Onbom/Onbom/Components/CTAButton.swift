//
//  CTAButton.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/10.
//

import SwiftUI

enum CTAButtonStyle {
    case primary(isDisabled: Bool)
    case secondary
    case expanded(isDisabled: Bool)
    case main
}

struct CTAButton {
    struct CustomButtonView: View {
        let style: CTAButtonStyle
        let action: () -> Void
        let label: Text
        
        var body: some View {
            switch style {
            case .primary(let isDisabled):
                Button(action: action) {
                        label
                            .B1()
                            .multilineTextAlignment(.center)
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
                .disabled(isDisabled)
            case .secondary:
                Button(action: action) {
                    label
                        .B1()
                        .multilineTextAlignment(.center)
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
            case .expanded(let isDisabled):
                Button(action: action) {
                    label
                        .B1()
                        .multilineTextAlignment(.center)
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
                .disabled(isDisabled)
            case .main:
                Button(action: action) {
                    label
                        .B1()
                        .multilineTextAlignment(.center)
                }
                .buttonStyle(CTAButtonStyleModifiers(style: style))
            }
        }
        init(
            style: CTAButtonStyle,
            action: @escaping () -> Void,
            @ViewBuilder label: () -> Text
        ) {
            self.style = style
            self.action = action
            self.label = label()
        }
    }
}

public struct CTAButtonStyleModifiers: ButtonStyle {
    let style: CTAButtonStyle
    
    @ViewBuilder
    public func makeBody(configuration: Self.Configuration) -> some View {
        
        switch style {
        case let .primary(isDisabled):
            configuration.label
                .frame(maxWidth: .infinity)
                .padding(.vertical, 19)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 16).fill(isDisabled ? Color.Green3 : configuration.isPressed ? Color.Green5 : Color.Green4))
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
        case .secondary:
            configuration.label
                .foregroundColor(Color.Green4)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 19)
                .background(RoundedRectangle(cornerRadius: 16).fill( configuration.isPressed ? Color.Green3 : Color.Green2))
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
        case let .expanded(isDisabled):
            configuration.label
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 19)
                .background(isDisabled ? Color.Green3 : configuration.isPressed ? Color.Green5 : Color.Green4)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
        case .main:
            configuration.label
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 19)
                .background(RoundedRectangle(cornerRadius: 14).fill(configuration.isPressed ? Color.Green5 : Color.Green4))
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
}

struct CTAButtonExampleView: View {
    @State private var isDisabled = false
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        let dynamicHStack = dynamicTypeSize <= .xxxLarge ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
        
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    // 비활성화 체크를 위한 버튼
                    Button("check") {
                        isDisabled.toggle()
                    }
                    
                    // PrimaryButton
                    CTAButton.CustomButtonView(
                        style: .primary(isDisabled: isDisabled))
                    {
                        print()
                    } label: {
                        Text("다음")
                    }
                    .padding(.horizontal, 20)
                    
                    // SecondaryButton
                    CTAButton.CustomButtonView(
                        style: .secondary)
                    {
                        print()
                    } label: {
                        Text("다음")
                    }
                    .padding(.horizontal, 20)
                    
                    // ExpandedButton
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            stops: [
                                .init(color: .TPW, location : 0),
                                .init(color: .W, location : 0.48)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(maxWidth: .infinity, minHeight: 104)
                        CTAButton.CustomButtonView(
                            style: .expanded(isDisabled: isDisabled))
                        {
                            print()
                        } label: {
                            Text("다음")
                        }
                    }
                    
                    // MainCTAButton
                    ZStack {
                        LinearGradient(
                            stops: [
                                .init(color: .TPW, location : 0),
                                .init(color: .W, location : 0.28)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(maxWidth: .infinity, minHeight: 122)
                        CTAButton.CustomButtonView(
                            style: .main)
                        {
                            print()
                        } label: {
                            Text("다음")
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // VerticalCTAButton
                    ZStack {
                        LinearGradient(
                            stops: [
                                .init(color: .TPW, location : 0),
                                .init(color: .W, location : 0.16)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(maxWidth: .infinity, minHeight: 186)
                        VStack(spacing: 10) {
                            CTAButton.CustomButtonView(
                                style: .main)
                            {
                                print()
                            } label: {
                                Text("버튼 텍스트")
                            }
                            CTAButton.CustomButtonView(
                                style: .secondary)
                            {
                                print()
                            } label: {
                                Text("버튼 텍스트")
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // HorizontalCTAButton
                    ZStack {
                        LinearGradient(
                            stops: [
                                .init(color: .TPW, location : 0),
                                .init(color: .W, location : 0.28)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(maxWidth: .infinity, minHeight: 122)
                        HStack {
                            CTAButton.CustomButtonView(
                                style: .secondary)
                            {
                                print()
                            } label: {
                                Text("아니요")
                            }
                            CTAButton.CustomButtonView(
                                style: .main)
                            {
                                print()
                            } label: {
                                Text("네")
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // IDCardHorizontalCTAButton
                    ZStack {
                        LinearGradient(
                            stops: [
                                .init(color: .TPW, location : 0),
                                .init(color: .W, location : 0.28)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(maxWidth: .infinity, minHeight: 122)
                        dynamicHStack {
                            CTAButton.CustomButtonView(style: .secondary)
                            {
                                print()
                            } label: {
                                Text("재촬영")
                            }
                            .frame(maxWidth: dynamicTypeSize <= .xxxLarge ? 103 : .infinity)
                            
                            CTAButton.CustomButtonView(style: .main)
                            {
                                print()
                            } label: {
                                Text("다음")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}

struct CTAButtonExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CTAButtonExampleView()
    }
}
