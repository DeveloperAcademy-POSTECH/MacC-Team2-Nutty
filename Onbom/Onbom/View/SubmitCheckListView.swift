//
//  SubmitCheckListView.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/10.
//

import SwiftUI

struct SubmitCheckListView: View {
    @EnvironmentObject var application: ApplicationInfo
    @EnvironmentObject var homeNavigation: HomeNavigationViewModel
    
    var body: some View {
        HStack {
            Text("마지막으로\n신청 정보를 확인해 주세요")
                .H2()
                .foregroundColor(.B)
            Spacer()
        }
        .padding()
        
        ScrollView {
            Group {
                HStack {
                    Text("신청 종류")
                        .B1()
                        .foregroundColor(.G5)
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text("신규")
                            .foregroundColor(.G5)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.G4)
                    }
                }
                HStack {
                    Text("\(application.patientName)님과의 관계")
                        .B1()
                        .foregroundColor(.G5)
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text(application.agentRelation)
                            .foregroundColor(.G5)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.G4)
                    }
                }
                .padding(.bottom)
                .padding(.bottom)
            }
            .padding()
            
            HStack {
                Text("신청인")
                    .Cap5()
                    .foregroundColor(.PB4)
                    .padding(4)
                    .padding(.horizontal, 3)
                    .background(Capsule().fill(Color.PB2))
                Text("\(application.patientName)님 정보")
                    .T2()
                    .foregroundColor(.G6)
                    .padding(.leading, -4)
                Spacer()
            }
            .padding(.leading)
            
            Divider()
                .padding(.horizontal)
            
            Group {
                HStack {
                    Text("신청인 주민등록번호")
                        .B1()
                        .foregroundColor(.G5)
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text(application.patientID)
                            .foregroundColor(.G5)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.G4)
                    }
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("신청인 주민등록지")
                            .B1()
                            .foregroundColor(.G5)
                        Spacer()
                        Button {
                            //
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.G4)
                        }
                    }
                    .padding(.bottom, 2)
                    Text(application.patientAddress.cityAddress)
                    Text(application.patientAddress.detailAddress)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("신청인이 현재 살고 계신 주소지")
                            .B1()
                            .foregroundColor(.G5)
                        Spacer()
                        Button {
                            //
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.G4)
                        }
                    }
                    .padding(.bottom, 2)
                    Text(application.patientActualAddress.cityAddress)
                    Text(application.patientActualAddress.detailAddress)
                }
                .padding(.bottom)
                .padding(.bottom)
                
            }
            .padding()
            
            
            HStack {
                Text("대리인")
                    .Cap5()
                    .foregroundColor(.PB4)
                    .padding(4)
                    .padding(.horizontal, 3)
                    .background(Capsule().fill(Color.PB2))
                Text("\(application.agentName)님 정보")
                    .T2()
                    .foregroundColor(.G6)
                    .padding(.leading, -4)
                Spacer()
            }
            .padding(.leading)
            Divider()
                .padding(.horizontal)
            
            Group {
                HStack {
                    Text("대리인 주민등록번호")
                        .B1()
                        .foregroundColor(.G5)
                    Spacer()
                    Button {
                        //
                    } label: {
                        Text(application.agentID)
                            .foregroundColor(.G5)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.G4)
                    }
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("대리인 주소지")
                            .B1()
                            .foregroundColor(.G5)
                        Spacer()
                        Button {
                            //
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.G4)
                        }
                    }
                    .padding(.bottom, 2)
                    Text(application.agentAddress.cityAddress)
                    Text(application.agentAddress.detailAddress)
                }
            }
            .padding()
            Spacer()
            
            
            HStack() {
                Button {
                    //
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(.PB4)
                }
                Text("입력한 정보를 다음에도 사용할게요")
                Spacer()
            }
            .padding()
        }
        
        //CTA Button
        Button {
            homeNavigation.popToRoot()
        } label: {
            Text("메인으로 가기")
                .foregroundColor(Color.white)
                .B1()
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
        }
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.PB4))
        .padding()
        .navigationBarBackButton()
    }
}

struct SubmitCheckListView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitCheckListView()
            .environmentObject(ApplicationInfo())
    }
}
