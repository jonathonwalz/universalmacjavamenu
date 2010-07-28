//
//  OCMMenu.h
//  
//
// Copyright 2010 Jonathon Walz
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <Cocoa/Cocoa.h>
#import "me_walz_mac_menu_MMenu.h"

@interface OBCMMenu : NSMenu {
@private
    jobject jref;
}

@property (nonatomic, assign) jobject jref;

- (id)initWithMenu:(jobject)menu inEnv:(JNIEnv*)env;

+ (OBCMMenu*)getMenuFrom:(JNIEnv*)env menu:(jobject)jmenu;

@end