//
//  spacebar-bridging.h
//  spacebar
//
//  Created by Bram on 26/12/2022.
//

#ifndef Spacebar_Bridging_Header_h
#define Spacebar_Bridging_Header_h


#import <Foundation/Foundation.h>

int _CGSDefaultConnection();
id CGSCopyManagedDisplaySpaces(int conn);
id CGSCopyActiveMenuBarDisplayIdentifier(int conn);

#endif /* spacebar_bridging_h */
