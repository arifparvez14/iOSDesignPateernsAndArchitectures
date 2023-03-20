import UIKit

class FacadeRealWorld {
    func testFacedeRealWorld() {
        let imageView = UIImageView()
        print("Let's set an image for the image view")
        clientCode(imageView)
        print("Image has been set")
    }
    
    fileprivate func clientCode(_ imageView: UIImageView) {
        let url = URL(string: "www.example.com/logo")
        imageView.downloadImage(at: url)
    }
}

private extension UIImageView {
    /// This extension plays a facede role.

    func downloadImage(at url: URL?) {

        print("Start downloading...")

        let placeholder = UIImage(named: "placeholder")

        ImageDownloader().loadImage(at: url,
                                    placeholder: placeholder,
                                    completion: { image, error in
            print("Handle an image...")

            /// Crop, cache, apply filters, whatever...

            self.image = image
        })
    }
}

private class ImageDownloader {
    /// Third party library or your own solution (subsystem)

    typealias Completion = (UIImage, Error?) -> ()
    typealias Progress = (Int, Int) -> ()

    func loadImage(at url: URL?,
                   placeholder: UIImage? = nil,
                   progress: Progress? = nil,
                   completion: Completion) {
        /// ... Set up a network stack
        /// ... Downloading an image
        /// ...
        completion(UIImage(), nil)
    }
}
