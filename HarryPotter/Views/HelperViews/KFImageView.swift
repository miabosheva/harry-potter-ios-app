import SwiftUI
import Kingfisher

struct KFImageView: View {
    
    var imageUrl: String
    var aspectRatio = ContentMode.fill
    
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
                    if isLoading {
                        LoadingView()
                    } else {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.gray)
                    }
                }
                .onSuccess { result in
                    print("Image loaded from cache: \(result.cacheType)")
                    isLoading = false
                }
                .onFailure { error in
                    print("Error: \(error)")
                    isLoading = false
                }
                .aspectRatio(contentMode: aspectRatio)
        }
    }
}

#Preview {
    KFImageView(imageUrl: "https://raw.githubusercontent.com/fedeperin/potterapi/main/public/images/characters/james_potter.png")
}
