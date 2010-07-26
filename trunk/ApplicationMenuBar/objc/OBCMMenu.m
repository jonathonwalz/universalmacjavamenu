//
//  OCMMenu.m
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

#import "OBCMMenu.h"
#import "OBCMMenuBar.h"
#import "OBCMMenuItem.h"

static NSMutableArray *menus;

@implementation OBCMMenu

@synthesize jref;

- (id)initWithMenu:(jobject)menu inEnv:(JNIEnv*)env {
    if ((self = [super initWithTitle:@""])) {
        self.jref = (*env)->NewGlobalRef(env, menu);
        [menus addObject:self];
        
        jfieldID fid;
        jclass cls = (*env)->GetObjectClass(env,menu);
        fid = (*env)->GetFieldID(env, cls, "title","Ljava/lang/String;");
        if (fid!=NULL) {
            jstring jtitle = (*env)->GetObjectField(env,menu, fid);
            const char *str = (*env)->GetStringUTFChars(env, jtitle, NULL);
            if (str!=NULL) {
                NSString *string = [NSString stringWithUTF8String:str];
                [self setTitle:string];
                (*env)->ReleaseStringUTFChars(env,jtitle,str);
            }
        }
        
        [self setAutoenablesItems:NO];
    }
    
    return self;
}

- (void)dealloc {
    [menus removeObject:self];
    
    JNIEnv *env; 
    (*cachedjvm)->GetEnv(cachedjvm,(void **)&env, JNI_VERSION_1_6);
    (*env)->DeleteGlobalRef(env, self.jref);
    
    [super dealloc];
}

+ (void) initialize {
    if ([self class] == [OBCMMenu class]) {
        menus = [[NSMutableArray alloc] init];
    }
}

+ (OBCMMenu*)getMenuFrom:(JNIEnv*)env menu:(jobject)jmenu {
    for (OBCMMenu *menu in menus) {
        if ((*env)->IsSameObject(env, jmenu, menu.jref)) {
            return menu;
        }
    }
    return nil;
}

@end


/*
 * Class:     me_walz_mac_menu_MMenu
 * Method:    doAddMenuItem
 * Signature: (Lme/walz/mac/menu/MMenuItem;)V
 */
JNIEXPORT void JNICALL Java_me_walz_mac_menu_MMenu_doAddMenuItem (JNIEnv *env, jobject menu, jobject item) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    OBCMMenu *menuObj = [OBCMMenu getMenuFrom:env menu:menu];
    if (menuObj!=nil) {
        OBCMMenuItem *itemObj = [OBCMMenuItem getMenuItemFrom:env item:item];
        if (itemObj==nil) {
            itemObj = [[[OBCMMenuItem alloc] initWithItem:item inEnv:env] autorelease];
        }
        [menuObj addItem:itemObj];
    }
    [pool release];
}

/*
 * Class:     me_walz_mac_menu_MMenu
 * Method:    doRemoveMenuItem
 * Signature: (I)V
 */
JNIEXPORT void JNICALL Java_me_walz_mac_menu_MMenu_doRemoveMenuItem (JNIEnv *env, jobject menu, jint itemIndex) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    OBCMMenu *menuObj = [OBCMMenu getMenuFrom:env menu:menu];
    if (menuObj!=nil) {
        [menuObj removeItemAtIndex:itemIndex];
    }
    [pool release];
}