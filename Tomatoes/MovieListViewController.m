//
//  MovieListViewController.m
//  Tomatoes
//
//  Created by Vasanthy Kolluri on 1/11/14.
//  Copyright (c) 2014 Vasanthy Kolluri. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieCell.h"

@interface MovieListViewController ()

@property(nonatomic, strong) NSArray *movies;
@property(nonatomic, strong) NSMutableArray *myMovies;

@end

@implementation MovieListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //self.movies = [NSArray array];
        //self.myMovies = [NSMutableArray array];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.movies = [NSArray array];
        self.myMovies = [NSMutableArray array];
    }
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.movies = [object valueForKeyPath:@"movies"];
        
        for(int i = 0; i < [self.movies count]; i++) {
            NSDictionary *movie = [self.movies objectAtIndex:i];

            Movie *m = [[Movie alloc] initWithDictionary:movie];
            [self.myMovies addObject:m];
            
        }
       // NSLog(@"%@", object);
        
        [self.tableView reloadData];

    }];
    
    return self;
}


- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
        queue:[NSOperationQueue mainQueue]
        completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
     if ( !error )
     {
        UIImage *image = [[UIImage alloc] initWithData:data];
        completionBlock(YES,image);
    } else{
        completionBlock(NO,nil);
    }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"MovieCell";
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Movie *movie = [self.myMovies objectAtIndex:indexPath.row];
    
  
    cell.movieTitleLabel.text = movie.title;
    cell.movieSynopsisLabel.text = movie.synopsis;
    cell.movieCastLabel.text = movie.cast;
   // cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:movie.imageURL]]];
    
    // download the image asynchronously
    [self downloadImageWithURL:[NSURL URLWithString:movie.imageURL] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            // change the image in the cell
            cell.imageView.image = image;
            
            // cache the image for use later (when scrolling up)
            //movie.image = image;
        }
    }];
    
    return cell;
    
}

@end
