import SwiftUI

enum House: String, CaseIterable {
    case gryffindor = "Gryffindor"
    case hufflepuff = "Hufflepuff"
    case ravenclaw = "Ravenclaw"
    case slytherin = "Slytherin"
    case noHouse = "No House"
}

extension House {
    var color: Color {
        switch self {
        case .gryffindor:
            return Color(red: 0.76, green: 0.13, blue: 0.16)
        case .hufflepuff:
            return Color(red: 0.96, green: 0.77, blue: 0.05)
        case .ravenclaw:
            return Color(red: 0.05, green: 0.16, blue: 0.44)
        case .slytherin:
            return Color(red: 0.06, green: 0.25, blue: 0.12)
        case .noHouse:
            return Color.gray
        }
    }
    
    var image: UIImage? {
        switch self {
        case .gryffindor:
            return UIImage(named: "gryffindor")
        case .hufflepuff:
            return UIImage(named: "hufflepuff")
        case .ravenclaw:
            return UIImage(named: "ravenclaw")
        case .slytherin:
            return UIImage(named: "slytherin")
        case .noHouse:
            return nil
        }
    }
    
    var motto: String {
        switch self {
        case .gryffindor:
            return "Their daring, nerve, and chivalry set Gryffindors apart."
        case .ravenclaw:
            return "Wit beyond measure is man's greatest treasure."
        case .hufflepuff:
            return "You might belong in Hufflepuff, where they are just and loyal. Those patient Hufflepuffs are true, and unafraid of toil."
        case .slytherin:
            return "Slytherin will help you on your way to greatness."
        case .noHouse:
            return "No house motto available."
        }
    }
}

struct HousesCardView: View {
    
    let house: House
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.white)
                .frame(maxWidth: 85, maxHeight: 85)
                .overlay {
                    if let uiImage = house.image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 80, maxHeight: 80)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(100)
                    } else {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 80, maxHeight: 80)
                            .foregroundColor(.secondary)
                            .cornerRadius(100)
                    }
                }
                .padding(8)
            
            VStack(alignment: .leading) {
                
                Text("HOUSE")
                    .fontWeight(.thin)
                    .foregroundColor(.white)
                
                Text(house.rawValue)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 4)
            
                Text("\(house.motto)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(house.color.opacity(0.8))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    HousesCardView(house: House.gryffindor)
    HousesCardView(house: House.hufflepuff)
    HousesCardView(house: House.ravenclaw)
    HousesCardView(house: House.slytherin)
    HousesCardView(house: House.noHouse)
}
