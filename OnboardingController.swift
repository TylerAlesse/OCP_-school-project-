import UIKit
class OnboardingController: UIViewController, UIScrollViewDelegate, UINavigationControllerDelegate
{
    let backgroundColor = UIColor(red: 21.0/255.0, green: 100.0/255.0, blue: 190.0/255.0, alpha: 1.0)
    let slides = [
        [ "image": "OGP Logo", "text": "Keep track of your college applications with ease"],
        [ "image": "Chicago", "text": "Never forget any part of your college application again!"],
        [ "image": "bradley", "text": "Organizing your applications has never been easier"],
    ]
    let screen: CGRect = UIScreen.mainScreen().bounds
    var scroll: UIScrollView?
    var dots: UIPageControl?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = backgroundColor
        scroll = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: screen.width, height: screen.height * 0.9))
        scroll?.showsHorizontalScrollIndicator = false
        scroll?.showsVerticalScrollIndicator = false
        scroll?.pagingEnabled = true
        view.addSubview(scroll!)
        if (slides.count > 1) {
            dots = UIPageControl(frame: CGRect(x: 0.0, y: screen.height * 0.9, width: screen.width, height: screen.height * 0.05))
            dots?.numberOfPages = slides.count
            view.addSubview(dots!)
        }
        for var i = 0; i < slides.count; ++i {
            if let image = UIImage(named: slides[i]["image"]!) {
                let imageView: UIImageView = UIImageView(frame: getFrame(image.size.width, iH: image.size.height, slide: i, offset: screen.height * 0.15))
                imageView.image = image
                scroll?.addSubview(imageView)
            }
            if let text = slides[i]["text"] {
                let textView = UITextView(frame: CGRect(x: screen.width * 0.1 + CGFloat(i) * screen.width, y: screen.height * 0.75, width: screen.width * 0.8, height: 100.0))
                textView.text = text
                textView.editable = false
                textView.selectable = false
                textView.textAlignment = NSTextAlignment.Center
                textView.font = UIFont(name: "Helvetica Neue", size: 25)
                textView.textColor = UIColor.whiteColor()
                textView.backgroundColor = UIColor.clearColor()
                scroll?.addSubview(textView)
            }
            
                    
        }
        scroll?.contentSize = CGSizeMake(CGFloat(Int(screen.width) *  slides.count), screen.height * 0.5)
        scroll?.delegate = self
        dots?.addTarget(self, action: Selector("swipe:"), forControlEvents: UIControlEvents.ValueChanged)
        
        
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
       // button.setImage(UIImage?, forState: UIControlState)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("Skip intro", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)

    }
    
    
   func buttonAction(sender:UIButton!)
    {
        self.performSegueWithIdentifier("segue", sender: nil)
        
        print("button tapped")
    }
    func getFrame (iW: CGFloat, iH: CGFloat, slide: Int, offset: CGFloat) -> CGRect {
        let mH: CGFloat = screen.height * 0.50
        let mW: CGFloat = screen.width
        var h: CGFloat
        var w: CGFloat
        let r = iW / iH
        if (r <= 1) {
            h = min(mH, iH)
            w = h * r
        } else {
            w = min(mW, iW)
            h = w / r
        }
        return CGRectMake(
            max(0, (mW - w) / 2) + CGFloat(slide) * screen.width,
            max(0, (mH - h) / 2) + offset,
            w,
            h
        )
    }
    func swipe(sender: AnyObject) -> () {
        if let scrollView = scroll {
            let x = CGFloat(dots!.currentPage) * scrollView.frame.size.width
            scroll?.setContentOffset(CGPointMake(x, 0), animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) -> () {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        dots!.currentPage = Int(pageNumber)
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
//import UIKit
//class OnboardingController: UIViewController, UIScrollViewDelegate {
//    let backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
//    let slides = [
//        [ "image": "OGP Logo", "text": "Keep track of your college applications with ease"],
//        [ "image": "Chicago", "text": "Spread joy amongst your friends and family with your secret posts!"],
//        [ "image": "Question", "text": "Receive alerts when your friends post their thoughts about you"],
//    ]
//    let screen: CGRect = UIScreen.mainScreen().bounds
//    var scroll: UIScrollView?
//    var dots: UIPageControl?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = backgroundColor
//        scroll = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: screen.width, height: screen.height * 0.9))
//        scroll?.showsHorizontalScrollIndicator = false
//        scroll?.showsVerticalScrollIndicator = false
//        scroll?.pagingEnabled = true
//        view.addSubview(scroll!)
//        if (slides.count > 1) {
//            dots = UIPageControl(frame: CGRect(x: 0.0, y: screen.height * 0.9, width: screen.width, height: screen.height * 0.05))
//            dots?.numberOfPages = slides.count
//            view.addSubview(dots!)
//        }
//        for var i = 0; i < slides.count; ++i {
//            if let image = UIImage(named: slides[i]["image"]!) {
//                let imageView: UIImageView = UIImageView(frame: getFrame(image.size.width, iH: image.size.height, slide: i, offset: screen.height * 0.15))
//                imageView.image = image
//                scroll?.addSubview(imageView)
//            }
//            if let text = slides[i]["text"] {
//                let textView = UITextView(frame: CGRect(x: screen.width * 0.1 + CGFloat(i) * screen.width, y: screen.height * 0.75, width: screen.width * 0.8, height: 100.0))
//                textView.text = text
//                textView.editable = false
//                textView.selectable = false
//                textView.textAlignment = NSTextAlignment.Center
//                textView.font = UIFont(name: "Helvetica Neue", size: 17)
//                textView.textColor = UIColor.whiteColor()
//                textView.backgroundColor = UIColor.clearColor()
//                scroll?.addSubview(textView)
//            }
//        }
//        scroll?.contentSize = CGSizeMake(CGFloat(Int(screen.width) *  slides.count), screen.height * 0.5)
//        scroll?.delegate = self
//        dots?.addTarget(self, action: Selector("swipe:"), forControlEvents: UIControlEvents.ValueChanged)
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    func getFrame (iW: CGFloat, iH: CGFloat, slide: Int, offset: CGFloat) -> CGRect {
//        let mH: CGFloat = screen.height * 0.50
//        let mW: CGFloat = screen.width
//        var h: CGFloat
//        var w: CGFloat
//        let r = iW / iH
//        if (r <= 1) {
//            h = min(mH, iH)
//            w = h * r
//        } else {
//            w = min(mW, iW)
//            h = w / r
//        }
//        return CGRectMake(
//            max(0, (mW - w) / 2) + CGFloat(slide) * screen.width,
//            max(0, (mH - h) / 2) + offset,
//            w,
//            h
//        )
//    }
//    func swipe(sender: AnyObject) -> () {
//        if let scrollView = scroll {
//            let x = CGFloat(dots!.currentPage) * scrollView.frame.size.width
//            scroll?.setContentOffset(CGPointMake(x, 0), animated: true)
//        }
//    }
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) -> () {
//        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
//        dots!.currentPage = Int(pageNumber)
//    }
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
//}