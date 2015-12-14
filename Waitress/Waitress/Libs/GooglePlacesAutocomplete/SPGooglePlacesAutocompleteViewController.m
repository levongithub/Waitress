//
//  SPGooglePlacesAutocompleteViewController.m
//  SPGooglePlacesAutocomplete
//
//  Created by Stephen Poletto on 7/17/12.
//  Copyright (c) 2012 Stephen Poletto. All rights reserved.
//

#import "SPGooglePlacesAutocompleteViewController.h"
#import "SPGooglePlacesAutocompleteQuery.h"
#import "SPGooglePlacesAutocompletePlace.h"
#import "ProgressView.h"
#import "AFNetworking.h"



@interface SPGooglePlacesAutocompleteViewController (){
    PFGeoPoint *geoPoint;
}

@end

@implementation SPGooglePlacesAutocompleteViewController
@synthesize mapView;
@synthesize prevViewController;
@synthesize geoPoint;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] init];
        searchQuery.radius = 100.0;
        shouldBeginEditing = YES;
     }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [searchFiald setImage:[UIImage imageNamed:@"searchIconHome"]
               forSearchBarIcon:UISearchBarIconSearch
                          state:UIControlStateNormal];
    
    [searchFiald setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchBack.png"] forState:UIControlStateNormal];

    [[UISearchBar appearance]setBackgroundImage:[[UIImage alloc] init]];
    UITextField *txtSearchField = [searchFiald valueForKey:@"_searchField"];
    txtSearchField.font = [UIFont fontWithName:@"Ubuntu" size:15];
    txtSearchField.textColor = [UIColor blackColor];
    
    self.mapView.delegate = self;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(handleGesture:)];
    tgr.numberOfTapsRequired = 1;
    [mapView addGestureRecognizer:tgr];
    
    [btnCancelDone setTitle:@"Done" forState:UIControlStateNormal];
}
- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    [mapView removeAnnotation:selectedPlaceAnnotation];
    
    selectedPlaceAnnotation = [[MKPointAnnotation alloc] init];
    
    ProgressView *progressView = [[ProgressView alloc]init];
    [progressView showInView:self.view];
    
    CGPoint touchPoint = [gestureRecognizer locationInView:mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [mapView convertPoint:touchPoint toCoordinateFromView:mapView];
    
    
//    CLGeocoder *ceo = [[CLGeocoder alloc]init];
//    CLLocation *loc = [[CLLocation alloc]initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude]; //insert your coordinates

    @try {
    searchFiald.text = @"";
    AFHTTPRequestOperationManager *afmanager = [AFHTTPRequestOperationManager manager];
    [afmanager GET:@"https://maps.googleapis.com/maps/api/geocode/json"
        parameters:@{@"latlng" : [NSString stringWithFormat:@"%f,%f", touchMapCoordinate.latitude, touchMapCoordinate.longitude],
                     @"key":@"AIzaSyBchbhjmW2WKsohE9sUkyxkichhJiQX7Uc",
                     @"result_type":@"locality",
                     @"language":@"en"}
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               @try{
                   NSLog(@"JSON: %@", responseObject);
                   NSString * country;
                   NSString * locality;
                   NSDictionary * dictionory1 = responseObject;
                   [progressView hidden];

                   if (![[dictionory1 objectForKey:@"status"] isEqualToString:@"OK"]) {
                       return ;
                   }
                   NSArray * array1 = [dictionory1 objectForKey:@"results"];
                   NSDictionary * dictionory2 = array1[0];
                   NSArray * array2 = [dictionory2 objectForKey:@"address_components"];
                   for (NSDictionary * dic  in array2) {
                       NSArray * ar = [dic objectForKey:@"types"];
                       if ([ar[0] isEqualToString:@"locality"]) {
                           
                           locality = [dic objectForKey:@"long_name"];
                           NSLog(@"%@",[dic objectForKey:@"long_name"]);
                           
                       }else if ([ar[0] isEqualToString:@"country"]){
                           
                           country = [dic objectForKey:@"long_name"];
                           NSLog(@"%@",[dic objectForKey:@"long_name"]);
                           
                       }
                   }
               
         
                   NSString * address = [NSString stringWithFormat:@"%@, %@",locality,country];
        
                                    selectedPlaceAnnotation.title = address;
                                     if ([address isEqualToString:@""]) {
                                         searchFiald.text = @"Undefined";
                                     }else{
                                         searchFiald.text = address;
                                     }
               }@catch(NSException * ex){
                   return;
               }
           }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               NSLog(@"Error: %@", error);
           }];
    selectedPlaceAnnotation.coordinate = touchMapCoordinate;
    geoPoint = [PFGeoPoint geoPointWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];

    [mapView addAnnotation:selectedPlaceAnnotation];
    }
    @catch (NSException *exception) {
        return;
    }

}
- (void)viewDidUnload {
    
    [super viewDidUnload];
    [self setMapView:nil];
    [super viewDidUnload];
}

- (void)dealloc {
}
- (void) viewWillDisappear:(BOOL)animated{
    UIViewController * cont ;
    cont = self.navigationController.viewControllers[self.navigationController.viewControllers.count -1];
    if ([@"SearchViewController" isEqualToString:[NSString stringWithFormat:@"%@",[cont class]]]) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    [super viewWillDisappear:animated];
}
- (IBAction)recenterMapToUserLocation:(id)sender {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.0002;
    span.longitudeDelta = 0.0002;
    
    region.span = span;
    region.center = self.mapView.userLocation.coordinate;
    
    [self.mapView setRegion:region animated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResultPlaces count];
}
- (SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [searchResultPlaces objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SPGooglePlacesAutocompleteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:16.0];
//    if (indexPath.row == 0) {
//      
//       // cell.textLabel.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"userAddress"];
//        
//        
//    }else{
    
      cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
        
//    }
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)recenterMapToPlacemark:(CLPlacemark *)placemark {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    region.span = span;
    region.center = placemark.location.coordinate;
    
    [self.mapView setRegion:region];
}

- (void)addPlacemarkAnnotationToMap:(CLPlacemark *)placemark addressString:(NSString *)address {
    [self.mapView removeAnnotation:selectedPlaceAnnotation];
    
    selectedPlaceAnnotation = [[MKPointAnnotation alloc] init];
    selectedPlaceAnnotation.coordinate = placemark.location.coordinate;
    NSString * location1 = address;
    location1= [location1 stringByReplacingOccurrencesOfString:@",(null)" withString:@""];
    location1 = [location1 stringByReplacingOccurrencesOfString:@"(null)," withString:@""];
    location1 = [location1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    selectedPlaceAnnotation.title = location1;
    
    [searchFiald setText:location1];
    [self.mapView addAnnotation:selectedPlaceAnnotation];
}

- (void)dismissSearchControllerWhileStayingActive {
    // Animate out the table view.
    tavleViewLocation.hidden = YES;
    
    [searchFiald resignFirstResponder];
    [btnCancelDone setTitle:@"Done" forState:UIControlStateNormal];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
      SPGooglePlacesAutocompletePlace *place = [self placeAtIndexPath:indexPath];
        [place resolveToPlacemark:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
            if (error) {
                SPPresentAlertViewWithErrorAndTitle(error, @"Could not map selected Place");
            } else if (placemark) {
                
                [self addPlacemarkAnnotationToMap:placemark addressString:addressString];
                [self recenterMapToPlacemark:placemark];
               
                geoPoint = [PFGeoPoint geoPointWithLatitude:placemark.location.coordinate.latitude longitude:placemark.location.coordinate.latitude];
                
                if([btnCancelDone.titleLabel.text isEqualToString:@"Cancel"] && [prevViewController isEqualToString:@"swop"])
                    [btnCancelDone setTitle:@"Done" forState:UIControlStateNormal];
               
                [self dismissSearchControllerWhileStayingActive];
            }
        }];

//    }
}
#pragma mark -
#pragma mark UISearchDisplayDelegate
- (void)handleSearchForSearchString:(NSString *)searchString {
    
    searchQuery.location = self.mapView.userLocation.coordinate;
    searchQuery.input = searchString;
    
    
    [searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            SPPresentAlertViewWithErrorAndTitle(error, @"Could not fetch Places");
        } else {
            searchResultPlaces = places;
            [tavleViewLocation reloadData];
        }
    }];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self handleSearchForSearchString:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark -
#pragma mark UISearchBar Delegate
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    if (shouldBeginEditing) {
        tavleViewLocation.hidden = NO;
        [btnCancelDone setTitle:@"Cancel" forState:UIControlStateNormal];
    }
       shouldBeginEditing = YES;
}
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (![searchBar isFirstResponder]) {
        // User tapped the 'clear' button.
        shouldBeginEditing = NO;
//        [self.searchDisplayController setActive:NO];
        [self.mapView removeAnnotation:selectedPlaceAnnotation];
    }
    [self handleSearchForSearchString:searchBar.text];
}
- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    
}
- (IBAction)txtSearchEditBegin:(UITextField *)sender {
    
    if (shouldBeginEditing) {
        // Animate in the table view.
//        NSTimeInterval animationDuration = 0.3;
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:animationDuration];
//        self.searchDisplayController.searchResultsTableView.alpha = 1.0;
//        [UIView commitAnimations];
        tavleViewLocation.hidden = NO;
        
//        [self.searchDisplayController.searchBar setShowsCancelButton:YES animated:YES];
    }
    shouldBeginEditing = YES;
}
- (IBAction)txtSearchChange:(UITextField *)sender {
    
    if (![sender isFirstResponder]) {
        // User tapped the 'clear' button.
        shouldBeginEditing = NO;
//        [self.searchDisplayController setActive:NO]; 
        [self.mapView removeAnnotation:selectedPlaceAnnotation];
    }
    [self handleSearchForSearchString:sender.text];
}

#pragma mark -
#pragma mark MKMapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapViewIn viewForAnnotation:(id <MKAnnotation>)annotation {
    if (mapViewIn != self.mapView || [annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
        static NSString *annotationIdentifier = @"SPGooglePlacesAutocompleteAnnotation";
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (!annotationView) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        }
        annotationView.animatesDrop = YES;
    
        if(![prevViewController isEqualToString:@"swop"])
            annotationView.canShowCallout = YES;
        return annotationView;
    
}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    // Whenever we've dropped a pin on the map, immediately select it to present its callout bubble.
    [self.mapView selectAnnotation:selectedPlaceAnnotation animated:YES];
}

- (void)annotationDetailButtonPressed {
}
- (void) textFieldDidBeginEditing:(UITextField *)textField{
    
//    [txtSearch becomeFirstResponder];
}
- (IBAction)btnCancelClick {
    
    if ([[[btnCancelDone titleLabel]text] isEqualToString:@"Cancel"]) {
        
        [searchFiald resignFirstResponder];
        tavleViewLocation.hidden = YES;
        [btnCancelDone setTitle:@"Done" forState:UIControlStateNormal];
        
    } else {
        
        [_googlePlacesDelegate didSelectLovctionWith:searchFiald.text geoPoint:geoPoint];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
