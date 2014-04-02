//
//  MyEventsViewController.h
//  PartyAppV1
//
//  Created by Dylan Humphrey on 3/29/14.
//
//

#import <UIKit/UIKit.h>

@interface MyEventsViewController : UITableViewController

/*
 This class will do the following:
 1. Get a NSMutableArray from all events 
 2. Process the array to just show events that this currentuser is either a host of or invited to
 3. Display all those events in a table view in sections, Hosting, and Invited to
 4. Create a detail view for this that will enable user to change things about the selected event if a host of it
 5. Create a detail view for this that will enable the user to observe things about the event he is invited to
 */

@end
