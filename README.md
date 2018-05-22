# Kiip Native Extension for Adobe AIR  #

** Kiip Requires AIR 3.5 or Higher! **

Before you begin, update your AIR SDK to 3.5, available at [http://www.adobe.com/devnet/air/air-sdk-download.html](http://www.adobe.com/devnet/air/air-sdk-download.html).


## Include the Kiip library ##

**In Flash Professional:**

1. Create a new project of the type AIR for iOS.
2. Select File > Publish Settings.
3. Select the wrench icon next to Script for ActionScript Settings.
4. Select the Library Path tab.
5. Press the Browse for Native Extension (ANE) File button and select the `com.kiip.extensions.Kiip.ane` file.

**In Flash Builder 4.6:**

1. Go to Project Properties (right-click your project in Package Explorer and select Properties).
2. Select ActionScript Build Path and click the Native Extensions tab.
3. Click Add ANE and navigate to the `com.kiip.extensions.Kiip.ane` file.
4. Add the extension to the build target before compiling.

**In FlashDevelop:**

1. Copy the `KiipAPI.swc` file to your project folder.
2. In the explorer panel, right-click the SWC and select Add To Library.
3. Right-click the SWC file in the explorer panel again, select Options, and then select External Library.


## Update your application descriptor ##

In order to use the Kiip Extension on Android, you'll need to update the `manifestAdditions` block in your your `application.xml` file:

	  <android>
        <manifestAdditions><![CDATA[
			<manifest android:installLocation="auto">
			<uses-sdk android:targetSdkVersion="19"/>
			<uses-sdk android:minSdkVersion="14"/>
			    <uses-permission android:name="android.permission.INTERNET"/>
				<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
			</manifest>			
		]]></manifestAdditions>
    </android>

To use the extension for either iOS or Android, add the extension identifier to the `<extensions>` block in `application.xml`:

	  <extensions>
		    <extensionID>com.kiip.extensions.Kiip</extensionID>
		</extensions>

A sample application descriptor file is located in the `example` folder in the extension package zip file.

## Using the API ##

Refer to `/example/KiipExample.as` for a sample class demonstrating use of the extension.  Remember to replace the key and secret at the top with your own Kiip credentials.  Class documentation is available in `/docs/index.html`.

(Note for Flash Professional users: copy the `KiipExample.as` file to the same folder as your .fla; in the 'Document Class' setting in the properties window, type 'KiipExample'.  Add the extension and XML changes described above, and build and deploy.


## Building the application ##

**Flash CS6 or Flash Builder 4.6**

If you're using Flash Builder 4.6 or later, or Flash Professional CS6 or later, and have added the extension library as previously described, then you can compile as normal directly from the IDE. 

**FlashDevelop or Other Tools**

If not and you are building your app with the extension from the command line (or with FlashDevelop), then you'll need to specify the directory containing the `com.kiip.extensions.Kiip.ane` file.

Next is an example build command line:

`[PATH_TO_AIR_SDK]\bin\adt -package -target apk-debug -storetype pkcs12 -keystore [YOUR_KEYSTORE_FILE] -storepass [YOUR_PASSWORD] anesample.apk app.xml anesample.swf -extdir [DIRECTORY_CONTAINING_ANE_FILE]`



	


	
