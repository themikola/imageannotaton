//
//  createFromLibrary.h
//  AVCam
//
//  Created by Michael Cartmill on 7/02/2014.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImage+imageAlpha.h"


@interface createFromLibrary : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *playerContainer;
@property (nonatomic, strong) AVPlayer *player;

-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate;


@end












some changes


some more changes


some changes to the branch which I want to merge in the main