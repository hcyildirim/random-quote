//
//  QuoteViewController.m
//  Random Quotes
//
//  Created by H. Can Yıldırım on 14/05/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import "QuoteViewController.h"
#import <RestKit/RestKit.h>
#import "Quote.h"

@interface QuoteViewController ()

@end

@implementation QuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureRestKit];
    [self loadQuote];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"https://andruxnet-random-famous-quotes.p.mashape.com"];
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [objectManager.HTTPClient setDefaultHeader:@"X-Mashape-Key" value:@"YOUR MASHAPE KEY"];
    [objectManager.HTTPClient setDefaultHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [objectManager.HTTPClient setDefaultHeader:@"Accept" value:@"application/json"];
    
    // setup object mappings
    RKObjectMapping *quoteMapping = [RKObjectMapping mappingForClass:[Quote class]];
    [quoteMapping addAttributeMappingsFromDictionary:@{
                                                            @"quote": @"quote",
                                                            @"author": @"author",
                                                            @"category": @"category"
                                                            }];
    
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:quoteMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:nil
                                                keyPath:nil
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}


- (void)loadQuote
{
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  Quote *quote = [mappingResult firstObject];
                                                  
                                                  _labelCategory.text = [quote.category uppercaseString];
                                                  _labelQuote.text = quote.quote;
                                                  _labelAuthor.text = quote.author;
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"There is no data in andruxnet: %@", error);
                                              }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonRefreshOnClick:(id)sender {
    [self loadQuote];
}
@end
