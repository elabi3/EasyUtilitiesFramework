//
//  Created by
//

#import "ImagenGrandeViewController.h"

@interface ImagenGrandeViewController ()

@end

@implementation ImagenGrandeViewController

- (id)initWithImage:(UIImage *) image
{    
    self = [super init];
    if (self) {
        self.image = image;
        self.title = @"";
        minZoomScale = 1;
        maxZoomScale = 3;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"CloseWindow", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(handlerDone)];
    self.navigationItem.leftBarButtonItem = done;
    self.view.backgroundColor = [UIColor colorWithRed:(190/255.0) green:(187/255.0) blue:(186/255.0) alpha:1.0];
    
    // Cargamos los elementos que van sobre el view
    [self loadImageView];
    [self loadScrollWithImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) loadImageView {
    imageView = [[UIImageView alloc] init];
    double proporcion = self.view.frame.size.width/self.image.size.width;
    
    CGRect frame;
    frame.size.width = self.image.size.width * proporcion;
    frame.size.height = self.image.size.height * proporcion;
    frame.origin.x = 0;
    //frame.origin.y = (self.view.frame.size.height - frame.size.height)/2;
    frame.origin.y = 0;
    imageView.frame = frame;
    imageView.image = self.image;
}

-(void) loadScrollWithImageView {
    scrollView =[[UIScrollView alloc] initWithFrame:self.view.frame];
    [scrollView setContentSize: CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.delegate = self;
    
    scrollView.contentMode = (UIViewContentModeScaleAspectFit);
    scrollView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    // Indicamos los valores maximo y minimo de zoom posibles 
    scrollView.maximumZoomScale = maxZoomScale;
    scrollView.minimumZoomScale = minZoomScale;
    scrollView.clipsToBounds = YES;
    
    // Add Gestures
    UITapGestureRecognizer* tapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapToZoom:)];
    [tapRecognizer setNumberOfTapsRequired:2];
    [scrollView addGestureRecognizer:tapRecognizer];
    
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
}

-(void) handlerDone {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) doubleTapToZoom:(UITapGestureRecognizer *)recognizer {
    static BOOL zoomed=NO;
    
    if (!zoomed) { // si no hay zoom hecho
        [scrollView zoomToRect:CGRectMake([recognizer locationInView:recognizer.view].x, [recognizer locationInView:recognizer.view].y, scrollView.frame.size.width/maxZoomScale, scrollView.frame.size.height/maxZoomScale) animated:YES];
        zoomed=YES;
    } else {  // si ya habia zoom
        [scrollView zoomToRect:CGRectMake(0,
                                          0,
                                          scrollView.frame.size.width,
                                          scrollView.frame.size.height) animated:YES];
        zoomed=NO;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

@end
