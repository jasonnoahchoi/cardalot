//
//  LegalInformationViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/14/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "LegalInformationViewController.h"
#import <MMDrawerController.h>
#import "CardViewController.h"
@import WebKit;

@interface LegalInformationViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *attributionContainerView;
@property (nonatomic, strong) UIView *policyContainerView;
@property (nonatomic, strong) UIView *termsContainerView;

@end

@implementation LegalInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Legal";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCard)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.attributionCell = [UITableViewCell new];
    self.attributionCell.textLabel.text = @"Attributions";
    
    self.privacyPolicyCell = [UITableViewCell new];
    self.privacyPolicyCell.textLabel.text = @"Privacy Policy";
    
    self.termsOfServiceCell = [UITableViewCell new];
    self.termsOfServiceCell.textLabel.text = @"Terms of Use";

    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section) {
        case 0:  return 1;  // section 0 has 2 rows
        case 1:  return 1;  // section 1 has 2 row
        case 2: return 1;  // section 2 has 2 row
        default: return 0;
    };
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
                case 0: return self.attributionCell;
            }
        case 1:
            switch(indexPath.row) {
                case 0: return self.privacyPolicyCell;
            }
        case 2:
            switch (indexPath.row) {
                case 0: return self.termsOfServiceCell;
            }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.attributionContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:self.attributionContainerView];
            WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 92)];
            NSString *htmlForView = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"attributions" withExtension:@"html"] encoding:NSStringEncodingConversionAllowLossy error:nil];
            [webView loadHTMLString:htmlForView baseURL:[[NSBundle mainBundle] URLForResource:@"attributions" withExtension:@"html"]];
            
            UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [dismissButton setImage:[UIImage imageNamed:@"deletecircle"] forState:UIControlStateNormal];
            dismissButton.frame = CGRectMake(CGRectGetMaxX(self.attributionContainerView.frame) - 40, 32, 30, 30);
            [dismissButton addTarget:self action:@selector(dismissAttributionView) forControlEvents:UIControlEventTouchUpInside];
            
            [self.attributionContainerView addSubview:webView];
            [self.attributionContainerView addSubview:dismissButton];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            self.policyContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:self.policyContainerView];
            WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 92)];
            NSString *htmlForView = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"privacy" withExtension:@"html"] encoding:NSStringEncodingConversionAllowLossy error:nil];
            [webView loadHTMLString:htmlForView baseURL:[[NSBundle mainBundle] URLForResource:@"privacy" withExtension:@"html"]];
            
            UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [dismissButton setImage:[UIImage imageNamed:@"deletecircle"] forState:UIControlStateNormal];
            dismissButton.frame = CGRectMake(CGRectGetMaxX(self.policyContainerView.frame) - 40, 32, 30, 30);
            [dismissButton addTarget:self action:@selector(dismissPolicyView) forControlEvents:UIControlEventTouchUpInside];
            
            [self.policyContainerView addSubview:webView];
            [self.policyContainerView addSubview:dismissButton];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            self.termsContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:self.termsContainerView];
            
            WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 92)];
            NSString *htmlForView = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"terms" withExtension:@"html"] encoding:NSStringEncodingConversionAllowLossy error:nil];
            [webView loadHTMLString:htmlForView baseURL:[[NSBundle mainBundle] URLForResource:@"terms" withExtension:@"html"]];
            
            UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [dismissButton setImage:[UIImage imageNamed:@"deletecircle"] forState:UIControlStateNormal];
            dismissButton.frame = CGRectMake(CGRectGetMaxX(self.termsContainerView.frame) - 40, 32, 30, 30);
            [dismissButton addTarget:self action:@selector(dismissTermsView) forControlEvents:UIControlEventTouchUpInside];
            
            [self.termsContainerView addSubview:webView];
            [self.termsContainerView addSubview:dismissButton];
        }
    }
}

// Sets the section headings for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section) {
        case 0: return @"Attributions";
        case 1: return @"Privacy Policy";
        case 2: return @"Terms of Service";
    }
    return nil;
}

- (void)done {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCard {
    CardViewController *cardVC = [[CardViewController alloc] init];
    [self.navigationController pushViewController:cardVC animated:YES];
}

- (void)dismissAttributionView {
    [self.attributionContainerView removeFromSuperview];
}

- (void)dismissPolicyView {
    [self.policyContainerView removeFromSuperview];
}

- (void)dismissTermsView {
    [self.termsContainerView removeFromSuperview];
}

@end
