//
//  ChartViewController.h
//  engQuiz
//
//  Created by 박 찬기 on 12. 11. 6..
//  Copyright (c) 2012년 박 찬기. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartViewController : UIViewController<UIWebViewDelegate>{
    
    IBOutlet UIWebView *webView;
}

- (IBAction)backBtnEvent:(id)sender;
@end
