//
//  QuoteViewController.h
//  Random Quotes
//
//  Created by H. Can Yıldırım on 14/05/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *labelQuote;
@property (strong, nonatomic) IBOutlet UILabel *labelAuthor;
@property (strong, nonatomic) IBOutlet UILabel *labelCategory;

- (IBAction)buttonRefreshOnClick:(id)sender;

@end
