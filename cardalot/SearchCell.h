//
//  SearchCell.h
//  cardalot
//
//  Created by Ross McIlwaine on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell <UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchField;

@end
