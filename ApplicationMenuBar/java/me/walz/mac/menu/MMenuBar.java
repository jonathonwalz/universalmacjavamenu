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
import java.io.*;
import javax.swing.JFrame;

public class MMenuBar {
    public static boolean isLoaded;
	private static ArrayList<MMenu> menus = new ArrayList<MMenu>();
	
	private native static void doAddMenu(MMenu menu);
	
	public static void addMenu(MMenu menu) {
		menus.add(menu);
		doAddMenu(menu);
	}
	
	static {
        try {
            InputStream in = ClassLoader.getSystemClassLoader().getResourceAsStream("libAppMenuBar.jnilib");
            if (in == null) {
                throw new Exception("libname: libAppMenuBar.jnilib not found");
            }
                
            File tmplib = File.createTempFile("libAppMenuBar","jnilib");
            tmplib.deleteOnExit();
            OutputStream out = new FileOutputStream(tmplib);
            byte[] buf = new byte[1024];
            for (int len; (len = in.read(buf)) != -1;) {
                out.write(buf, 0, len);
            }
            in.close();
            out.close();
            System.load(tmplib.getAbsolutePath());
            isLoaded = true;
        } catch (Exception e) {isLoaded = false;}
	}
	
	public static void main(String [] args) {
		javax.swing.SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				MMenu connection = new MMenu("Connection");
				addMenu(connection);
                MMenuItem item = new MMenuItem("New", new MMenuItemListener() {
					@Override
					public void menuItemClicked(MMenuItem item) {
						// TODO Auto-generated method stub
						System.out.println("New");
					}
				});
				connection.addMenuItem(item);
                item.setKey("n");
                item = new MMenuItem("Close", new MMenuItemListener() {
					@Override
					public void menuItemClicked(MMenuItem item) {
						// TODO Auto-generated method stub
						System.out.println("Close");
					}
				});
				connection.addMenuItem(item);
                item.setKey("w");
				
				MMenu window = new MMenu("Window");
				addMenu(window);
				
				MMenu help = new MMenu("Help");
				addMenu(help);
				help.addMenuItem(new MMenuItem("Help", new MMenuItemListener() {
					@Override
					public void menuItemClicked(MMenuItem item) {
						// TODO Auto-generated method stub
						System.out.println("Help");
					}
				}));
				
				JFrame test = new JFrame();
				test.setVisible(true);
			}
		});
		
	}
}
