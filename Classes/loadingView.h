//
//  loadingView.h
//  IT-Dealer
//
//  Created by Julian Hays on 12/6/10.
//  Copyright 2010 Ratchet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loadingView : UIView {

}
- (id)addLoadingView:(UIView *)aSuperview loadMessage:(NSString *)message;
- (void)removeLoadingView;
@end
