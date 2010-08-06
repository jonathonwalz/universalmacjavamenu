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

package me.walz.mac.menu;

public class MMenuItem {
	private final MMenuItemListener listener;
	private String title;
	private int state;
    private boolean enabled;
	private String key;
    private final boolean seperator;
    public static final int OFF_STATE = 0;
    public static final int ON_STATE = 1;
    public static final int MIXED_STATE = 2;
    
	private native void state(int state);
    private native void title(String title);
	private native void enabled(boolean checked);
    private native void key(String key);
    
    public MMenuItem() {
        this.title = null;
        this.listener = null;
        seperator = true;
    }
    
	public MMenuItem(String title, MMenuItemListener listener) {
		this.title = title;
		this.listener = listener;
        this.key = "";
        seperator = false;
	}

	public void wasClicked() {
		listener.menuItemClicked(this);
	}
	
	public MMenuItemListener getListener() {
		return listener;
	}

    public void setTitle(String title) {
        this.title = title;
        title(title);
    }
    
	public String getTitle() {
		return title;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
		state(state);
	}
    
    public boolean getEnabled() {
		return enabled;
	}
    
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
		enabled(enabled);
	}

    public String getKey() {
		return key;
	}
    
	public void setKey(String key) {
        if (key==null)
            throw new NullPointerException();
		this.key = key;
		key(key);
	}
}
