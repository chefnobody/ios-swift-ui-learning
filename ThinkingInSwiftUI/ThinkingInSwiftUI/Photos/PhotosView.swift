//
//  PhotosView.swift
//  ThinkingInSwiftUI
//
//  Created by Aaron Connolly on 1/8/21.
//

import Combine
import SwiftUI

let PhotosUrl = URL(string: "https://picsum.photos/v2/list")!

struct PhotoView: View {
    @ObservedObject var photoLoader = ImageLoader()
    
    let photo: Photo
    
    var body: some View {
        VStack {
            if let image = photoLoader.image, !photoLoader.loading {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(CGSize(width: photo.width, height: photo.height), contentMode: .fit)
                    .border(Color.black)
            } else {
                Text("Loading image...")
                    .font(.caption)
            }
            Text(photo.author)
                .font(.headline)
            Text(photo.id)
                .font(.caption)
            Text("\(photo.height)h x \(photo.width)w")
                .font(.caption)
        }
        .onAppear {
            photoLoader.load(photo.downloadUrl)
        }
    }
}

struct PhotoListView: View {
    var isLoading: Bool
    var photos: [Photo]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if isLoading {
                    Text("Loading...")
                } else {
                    ForEach(photos) { photo in
                        NavigationLink(
                            destination: PhotoView(photo: photo),
                            label: { Text(photo.author) }
                        )
                    }
                }
            }
        }
        //.frame(width: .infinity, height: .infinity, alignment: .leading)
    }
}

struct PhotosView: View {
    @StateObject var photoLoader = DataLoader<Photo>(url: PhotosUrl)

    var body: some View {
        NavigationView {
            PhotoListView(
                isLoading: photoLoader.loading,
                photos: photoLoader.data
            )
                .alignmentGuide(.leading, computeValue: { _ in 0 })
                .onAppear {
                    self.photoLoader.load()
            }
            .navigationTitle("Photographers")
        }
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView(
            isLoading: false,
            photos: [
                Photo(id: "1",
                      author: "Author McDude",
                      width: 100,
                      height: 100,
                      url: URL(string: "https://unsplash.com/photos/yC-Yzbqy7PY")!,
                      downloadUrl: URL(string: "https://picsum.photos/id/0/5616/3744")!
                )
            ]
        )
    }
}
