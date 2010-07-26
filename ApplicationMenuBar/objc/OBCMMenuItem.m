//
//  OBCMMenuItem.m
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

#import "OBCMMenuItem.h"
#import "OBCMMenuBar.h"

static NSMutableArray *items;

@implementation OBCMMenuItem

@synthesize jref;

- (id)initWithItem:(jobject)item inEnv:(JNIEnv*)env {
    if ((self = [super initWithTitle:@"" action:@selector(clicked) keyEquivalent:@""])) {
        self.jref = (*env)->NewGlobalRef(env, item);
        [items addObject:self];
        
        jfieldID fid;
        jclass cls = (*env)->GetObjectClass(env,item);
        fid = (*env)->GetFieldID(env, cls, "title","Ljava/lang/String;");
        if (fid!=NULL) {
            jstring jtitle = (*env)->GetObjectField(env,item, fid);
            const char *str = (*env)->GetStringUTFChars(env, jtitle, NULL);
            if (str!=NULL) {
                NSString *string = [NSString stringWithUTF8String:str];
                [self setTitle:string];
                (*env)->ReleaseStringUTFChars(env,jtitle,str);
            }
        }
    }
    
    return self;
}

- (void)clicked {
    
}

- (void)dealloc {
    [items removeObject:self];
    
    JNIEnv *env; 
    (*cachedjvm)->GetEnv(cachedjvm,(void **)&env, JNI_VERSION_1_6);
    (*env)->DeleteGlobalRef(env, self.jref);
    
    [super dealloc];
}

+ (void) initialize {
    if ([self class] == [OBCMMenuItem class]) {
        items = [[NSMutableArray alloc] init];
    }
}

+ (OBCMMenuItem*)getMenuItemFrom:(JNIEnv*)env item:(jobject)jitem {
    for (OBCMMenuItem *item in items) {
        if ((*env)->IsSameObject(env, jitem, item.jref)) {
            return item;
        }
    }
    return nil;
}

@end

/*
 * Class:     me_walz_mac_menu_MMenuItem
 * Method:    checked
 * Signature: (Z)V
 */
JNIEXPORT void JNICALL Java_me_walz_mac_menu_MMenuItem_checked(JNIEnv *env, jobject item, jboolean checked) {
     NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    OBCMMenuItem *itemObj = [OBCMMenuItem getMenuItemFrom:env item:item];
    if (itemObj!=nil) {
        if (checked)
            [itemObj setState:NSOnState];
        else
            [itemObj setState:NSOffState];
    }
    [pool release];
}