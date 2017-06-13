//
//  ContainerViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 13.06.17.
//  ObjC-Source: http://sandmoose.com/post/35714028270/storyboards-with-custom-container-view-controllers
//  Modified and converted to Swift by me
//  This class handles two ChildViewControllers and methods to swap between them with Segues. Both ChildViewControllers can be used in one ContainerView.
//

import UIKit

class ContainerViewController: UIViewController {
    
    //MARK: - Variables & Outlets
    
    var segueIdentifierFirst = "embedFirst"
    var segueIdentifierSecond = "embedSecond"
    var currentSegueIdentifier : String!
    
    var firstViewController: UIViewController!
    var secondViewController: UIViewController!

    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // initialize the ContainerView with the part 1 ViewController.
        self.currentSegueIdentifier = segueIdentifierFirst
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print(self.childViewControllers.count)

        if (segue.identifier == segueIdentifierFirst) {
            if self.firstViewController == nil {
                self.firstViewController = segue.destination
            }
        }
        
        if (segue.identifier == segueIdentifierSecond) {
            if self.secondViewController == nil {
                self.secondViewController = segue.destination
            }
        }
        
        if (segue.identifier == segueIdentifierFirst)
        {
            if (self.childViewControllers.count > 0) {
                self.swapFromViewController(fromViewController: self.childViewControllers[0], toViewController:self.firstViewController)
            }
            else {
                self.addChildViewController(segue.destination)
                segue.destination.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                segue.destination.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                self.view.addSubview(segue.destination.view)
                segue.destination.didMove(toParentViewController: self)
            }
        }
        else if (segue.identifier == segueIdentifierSecond)
        {
            self.swapFromViewController(fromViewController: self.childViewControllers[0], toViewController:self.secondViewController)
        }
    }

    
    func swapFromViewController(fromViewController:UIViewController, toViewController:UIViewController)
    {
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    fromViewController.willMove(toParentViewController: nil)
    self.addChildViewController(toViewController)
    self.transition(from: fromViewController, to: toViewController, duration: 1.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: nil, completion: { _ in
            fromViewController.removeFromParentViewController()
            toViewController.didMove(toParentViewController: self)
        })
    }
    
    func swapViewControllers() {
        self.performSegue(withIdentifier: self.currentSegueIdentifier, sender: nil)
        print(self.childViewControllers.count)
    }
    
    func initialize(){
        self.performSegue(withIdentifier: "embedFirst", sender: nil)
        self.currentSegueIdentifier = "embedFirst"
    }
    
    //MARK: - Help-Methods

    // little help method, because CGRectMake was removed in Swift 3
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}
