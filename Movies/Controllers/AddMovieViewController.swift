//
//  AddMovieViewController.swift
//  Movies
//
//  Created by Youssef on 5/19/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import UIKit

public protocol AddMovieViewControllerDelegate: class {
    func addMovieViewController(_ addMovieViewController: AddMovieViewController,
                   didAddPersonalMovie personalMovie: PersonalMovie)
}

public class AddMovieViewController: UIViewController {

    @IBOutlet weak var moviePosterButton: UIButton!
    @IBOutlet weak var movieTitleTextField: UITextField!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    
    public weak var delegate: AddMovieViewControllerDelegate?
    
    private let imagePickerController: UIImagePickerController = {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = false
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .photoLibrary
        return pickerController
    }()
    
    private let personalMovieBuilder = PersonalMovieBuilder()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        moviePosterButton.imageView?.contentMode = .scaleAspectFill
        imagePickerController.delegate = self
        if let parentMoviesViewController = parent?.children.first as? MoviesViewController {
            self.delegate = parentMoviesViewController
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        movieOverviewTextView.resignFirstResponder()
        movieTitleTextField.resignFirstResponder()
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addMoviePoster(sender: UIButton) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func addMovieReleaseDate(sender: UIDatePicker) {
        personalMovieBuilder.setMovieReleaseDate(sender.date)
    }
    
    @IBAction func addMovie(sender: UIButton) {
        do {
            let personalMovie = try personalMovieBuilder.build()
            if let personalMovie = personalMovie {
                delegate?.addMovieViewController(self, didAddPersonalMovie: personalMovie)
                if let navigationController = parent as? UINavigationController {
                    navigationController.popViewController(animated: true)
                }
            }
        } catch PersonalMovieBuilderError.moviePosterImageNotFound {
            showAlert(title: "Missing Field", message: "Looks like you've forgotten to add a poster for your movie.")
        } catch PersonalMovieBuilderError.movieTitleNotFound {
            showAlert(title: "Missing Field", message: "Looks like you've forgotten to add a title for your movie.")
        } catch PersonalMovieBuilderError.movieOverviewNotFound {
            showAlert(title: "Missing Field", message: "Looks like you've forgotten to add an overview for your movie.")
        } catch PersonalMovieBuilderError.movieReleaseDateNotFound {
            showAlert(title: "Missing Field", message: "Looks like you've forgotten to add a release date for your movie.")
        } catch {
        }
    }
}

extension AddMovieViewController: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor != UIColor.label {
            textView.text = nil
            textView.textColor = UIColor.label
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Movie Overview"
            textView.textColor = UIColor.lightGray
        } else {
            personalMovieBuilder.setMovieOverview(textView.text)
        }
        
        textView.resignFirstResponder()
    }
}

extension AddMovieViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let movieTitle = textField.text {
            print("Typing")
            personalMovieBuilder.setMovieTitle(movieTitle)
        }
        
        textField.resignFirstResponder()
    }
}

extension AddMovieViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        moviePosterButton.setImage(image, for: .normal)
        personalMovieBuilder.setPosterImage(image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
