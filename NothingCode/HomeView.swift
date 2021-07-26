//
//  HomeView.swift
//  NothingCode
//
//  Created by Sample on 2021/7/26.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                
                Spacer()
                
                AvatarView(showProfile: $showProfile) // 向子组件传值需要 $
                
                Button(action: { self.showUpdate.toggle() }) {
                    Image(systemName: "bell")
                        .renderingMode(.original)
                        .font(.system(size: 16 , weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        // 双重投影 相当于现实生活中两个光源
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                }
                // 展开新视图 ios13+ 一个卡片一样的视图 用来快速获取信息使用的
                .sheet(isPresented: $showUpdate, content: {
                    UpdateList()
                })
            }
            .padding(.horizontal)
            
            // showsIndicators 滚动指示器显示
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(sectionData) { item in
                        GeometryReader { geometry in
                            SectionView(section: item)
                                // 这个不懂 15课程
                                .rotation3DEffect(Angle(degrees:
                                                           
                                      Double(geometry.frame(in: .global).minX - 30 ) / -20
                                ), axis: (x: 0, y: 10, z: 0))
                        }
                        .frame(width: 275, height: 275) //设置框架大小
                    }
                }
                .padding(30)
                .padding(.leading, 14)
                .padding(.bottom, 30)
            }
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(true))
    }
}

struct SectionView: View {
    var section: Section
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity,alignment: .leading)
            
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal,20)
        .frame(width: 275, height: 275)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}


struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype design in SwiftUI", text: "18 Section", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
    Section(title: "Build a SwiftUI app", text: "20 Section", logo: "Logo2", image: Image(uiImage: #imageLiteral(resourceName: "Card1")), color: Color("card2")),
    Section(title: "SwiftUI Advanced", text: "20 Section", logo: "Logo3", image: Image("Card3"), color: Color("card3"))
]
