//
//  OBCMMenuBar.m
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

#import "OBCMMenuBar.h"
#import "OBCMMenu.h"

JavaVM *cachedjvm;

@implementation OBCMMenuBar

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@end

/*
 * Class:     me_walz_mac_menu_MMenuBar
 * Method:    doAddMenu
 * Signature: (Lme/walz/mac/menu/MMenu;)V
 */
JNIEXPORT void JNICALL Java_me_walz_mac_menu_MMenuBar_doAddMenu(JNIEnv *env, jclass mmenubar, jobject menu) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"" action:nil keyEquivalent:@""];
	OBCMMenu *m = [[OBCMMenu alloc] initWithMenu:menu inEnv:env];
	[item setSubmenu:m];
	[m release];
	[[[NSApplication sharedApplication] mainMenu] addItem:item];
	[item release];
	[[[NSApplication sharedApplication] mainMenu] update];
    [pool release];
}

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *jvm, void *reserved) {
    cachedjvm = jvm;
    return JNI_VERSION_1_4;
}