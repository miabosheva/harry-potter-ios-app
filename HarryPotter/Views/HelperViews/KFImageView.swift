import SwiftUI
import Kingfisher

struct KFImageView: View {
    
    var imageUrl: String
    
    func url() -> URL? {
        return URL(string: imageUrl)
    }
    
    @State private var isLoading: Bool = true
    
    var body: some View {
        VStack {
            KFImage(url())
                .resizable()
                .serialize(as: .PNG)
                .placeholder{
                    Image(systemName: "photo.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.secondary)
                    
                }
                .onSuccess { result in
                    print("Image loaded from cache: \(result.cacheType)")
                }
                .onFailure { error in
                    print("Error: \(error)")
                }
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    KFImageView(imageUrl: "https://raw.githubusercontent.com/fedeperin/potterapi/main/public/images/characters/james_potter.png")
}
