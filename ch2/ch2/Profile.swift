//
//  Profile.swift
//  ch2
//
//  Created by Kelvin KUCH on 25.06.2023.
//

import SwiftUI

struct LoadingError: Error {}

struct Photo: Codable, Identifiable {
    var id: String
    var author: String
    var width: Int
    var height: Int
    var url: URL
    var download_url: URL
}

final class Remote<A>: ObservableObject {
    @Published var result: Result<A, Error>? = nil // nil means not loaded yet

    var value: A? { try? result?.get() }
    
    let url: URL
    let transform: (Data) -> A?

    init(url: URL, transform: @escaping (Data) -> A?) {
        self.url = url
        self.transform = transform
    }

    func load() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let d = data, let v = self.transform(d) {
                    self.result = .success(v)
                } else {
                    self.result = .failure(LoadingError())
                }
            }
        }.resume()
    }
}

struct PhotoView: View {
    @ObservedObject var image: Remote<UIImage>
    
    init(_ url: URL) {
        image = Remote(url: url, transform: { UIImage(data: $0 )})
    }
    
    var body: some View {
        Group {
            if image.value == nil {
                Text("Loading ...")
                    .onAppear {
                        self.image.load()
                    }
            } else {
                Image(uiImage: image.value!)
                    .resizable()
                    .aspectRatio(image.value!.size, contentMode: .fit)
            }
        }
    }
}

struct Profile: View {
    
    @ObservedObject var items = Remote(url: URL(string: "https://picsum.photos/v2/list")!, transform: {
        try? JSONDecoder().decode([Photo].self, from: $0)
    })

    var body: some View {
        NavigationView {
            if items.value == nil {
                Text("Loading ...")
                    .onAppear {
                        self.items.load()
                    }
            } else {
                List {
                    ForEach (items.value!) { photo in
                        Text(photo.author)
                    }
                }
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
