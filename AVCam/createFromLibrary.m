//
//  createFromLibrary.m
//  AVCam
//
//  Created by Michael Cartmill on 7/02/2014.
//  Copyright (c) 2014 Apple Inc. All rights reserved.
//

#import "createFromLibrary.h"

@interface createFromLibrary ()

@property(nonatomic, strong) AVAsset *asset1;
@property (nonatomic,strong) CALayer *refImage;

@end

@implementation createFromLibrary

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)play:(id)sender {
    [self startMediaBrowserFromViewController:self usingDelegate:self];

}


-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate {
    // 1 - Validations
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    // 2 - Get image picker
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = delegate;
    // 3 - Display image picker
    [self presentViewController:mediaUI animated:YES completion:nil];
  //  [controller presentModalViewController:mediaUI animated:YES];
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 1 - Get media type
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    // 2 - Dismiss image picker
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];

    [self dismissModalViewControllerAnimated:NO];
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef)mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        // 3 - Play the video
        
     
        UIImage *animationImagedown = [UIImage imageNamed:@"squat.png"];
        
        UIImage *newImage = [animationImagedown imageByApplyingAlpha:0.3];
        self.refImage = [CALayer layer];
        
        self.refImage = [CALayer layer];
        [self.refImage setContents:(id)[newImage CGImage]];
        self.refImage.frame = CGRectMake(40,100, 	self.playerContainer.frame.size.height
                                         , 	self.playerContainer.frame.size.width);
        [self.refImage setMasksToBounds:YES];
        [self.view.layer addSublayer:_refImage];
      
        [self.view.layer addSublayer:_refImage];
        self.asset1 = [AVAsset assetWithURL:[info objectForKey:UIImagePickerControllerMediaURL]];
        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:_asset1];
        AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
        [player play];
        self.player = player;
        
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        [self.playerContainer.layer addSublayer:playerLayer];
        playerLayer.frame = CGRectMake(0,0,(self.playerContainer.frame.size.width), (self.playerContainer.frame.size.height));
       // [self.view.layer addSublayer:playerLayer];
        
        
        /*
        
        MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc]
                                                 initWithContentURL:[info objectForKey:UIImagePickerControllerMediaURL]];
        [self presentMoviePlayerViewControllerAnimated:theMovie];
        // 4 - Register for the playback finished notification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
         */
    }
}

-(void)myMovieFinishedCallback:(NSNotification*)aNotification {
    [self dismissMoviePlayerViewControllerAnimated];
    MPMoviePlayerController* theMovie = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
}

@end
