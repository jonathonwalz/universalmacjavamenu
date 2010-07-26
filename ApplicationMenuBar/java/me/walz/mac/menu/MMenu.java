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

import java.util.ArrayList;

public class MMenu {
	private ArrayList<MMenuItem> items = new ArrayList<MMenuItem>();
	private final String title;
	
	private native void doAddMenuItem(MMenuItem menu);
	private native void doRemoveMenuItem(int index);
	
	public void addMenuItem(MMenuItem item) {
		items.add(item);
		doAddMenuItem(item);
	}

	public void removeMenuItem(MMenuItem item) {
		int index = items.indexOf(item);
		items.remove(index);
		doRemoveMenuItem(index);
	}
	
	public MMenu(String title) {
		this.title = title;
	}
	
	public String getTitle() {
		return title;
	}
}
