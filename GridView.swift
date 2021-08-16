//
//  GridView.swift
//  iBSwiftUIExample
//
//  Created by Achintha Kahawalage on 2021-06-29.
//

import SwiftUI

struct GridView: View {

    
    var body: some View {
       
        NavigationView{
            Home2()
                .navigationTitle("bubble View")
        }
     
    }
}


struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}


struct Home2: View {
    
    // Sample Data For ScrollView...
    
    @State var sampleData : [Date] = Array(repeating: Date(), count: 0)
    
    // since it is vertical scrollview...
    // so 2d array...
    
    @State var rows : [[Date]] = []
    
    // padding = 30
    let width = UIScreen.main.bounds.width - 30
    
    var body: some View{
        
        ScrollView{
            
            VStack(spacing: 0){
                
                ForEach(rows.indices,id: \.self){index in
                    
                    HStack(spacing: -10){
                        
                        ForEach(rows[index],id: \.self){value in
                            
                            Circle()
                                .fill(Color.red)
                                .frame(width: (width - 20) / 3, height: 100)
                                .offset(x: getOffset(index: index))
                        }
                    }
                }
            }
            .padding()
            .frame(width: width)
        }
        // menu Button...
        .toolbar(content: {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Menu(content: {
                    
                    Button(action: {
                        withAnimation(.spring()){
                            rows.removeAll()
                            sampleData.append(Date())
                            generateHoney()
                        }
                    }, label: {
                        
                        Text("Add New Item")
                    })
                    
                }) {
                    
                    Image(systemName: "ellipsis.circle")
                        .font(.title)
                }
            }
        })
        .onAppear(perform: {
            
            generateHoney()
        })
    }
    
    // setting extra honey Comb Views By calculating Offset...
    
    func getOffset(index: Int)->CGFloat{
        
        let current = rows[index].count
        
        // moving half the width...
        
        let offset = ((width - 20) / 3) / 2
        
        if index != 0{
            
            let previous = rows[index - 1].count
            
            if current == 1{
                
                if previous == 3{
                    
                    return -offset
                }
            }
            
            if current == previous{
                return -offset
            }
        }
        
        return 0
    }
    
    // generating HoneyComb Rows.....
    
    func generateHoney(){
        
        var count = 0
        
        // you can use anything here....
        var generated : [Date] = []
        
        for i in sampleData{
            
            generated.append(i)
            
            // checking and creating rows...
            
            if generated.count == 3{
                
                if let last = rows.last{
                    
                    if last.count == 2{
                        
                        rows.append(generated)
                        generated.removeAll()
                    }
                }
                
                // for first time no data...
                
                if rows.isEmpty{
                    
                    rows.append(generated)
                    generated.removeAll()
                }
            }
            
            if generated.count == 2{
                
                if let last = rows.last{
                    
                    if last.count == 3{
                        
                        rows.append(generated)
                        generated.removeAll()
                    }
                }
            }
            
            count += 1
            // for exhaust data or single data...
            
            if count == sampleData.count && !generated.isEmpty{
                
                rows.append(generated)
            }
        }
    }
}

