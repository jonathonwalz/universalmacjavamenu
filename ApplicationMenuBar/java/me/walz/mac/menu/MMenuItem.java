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
	private final String title;
	private Boolean checked;
	
	private native void checked(boolean checked);
	
	public MMenuItem(String title, MMenuItemListener listener) {
		this.title = title;
		this.listener = listener;
	}

	public void wasClicked() {
		listener.menuItemClicked(this);
	}
	
	public MMenuItemListener getListener() {
		return listener;
	}

	public String getTitle() {
		return title;
	}

	public boolean getChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
		checked(checked);
	}
}
