//
//  SPGooglePlacesAutocompleteViewController.h
//  SPGooglePlacesAutocomplete
//
//  Created by Stephen Poletto on 7/17/12.
//  Copyright (c) 2012 Stephen Poletto. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@protocol SPGooglePlacesAutocompleteQueryDelegate <NSObject>

@optional

- (void) didSelectLovctionWith:(NSString *)address geoPoint:(PFGeoPoint *)geoPoint;

@end

@class SPGooglePlacesAutocompleteQuery;
@interface SPGooglePlacesAutocompleteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate,UITextFieldDelegate, UISearchBarDelegate, MKMapViewDelegate,UISearchBarDelegate> {
    
    NSArray *searchResultPlaces;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    MKPointAnnotation *selectedPlaceAnnotation;
    
    BOOL shouldBeginEditing;
    __weak IBOutlet UISearchBar *searchFiald;
    __weak IBOutlet UIButton *btnCancelDone;
    __weak IBOutlet UITableView *tavleViewLocation;
    __weak IBOutlet UITextField *txtSearch;
}
@property (nonatomic,weak) id <SPGooglePlacesAutocompleteQueryDelegate> googlePlacesDelegate;
@property (nonatomic,strong) PFGeoPoint * geoPoint;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) NSString *prevViewController;

@end
