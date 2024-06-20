Every app project must have an `AndroidManifest.xml` file, with precisely that name, at the root of the [project source set](https://developer.android.com/studio/build#sourcesets). The manifest file describes essential information about your app to the Android build tools, the Android operating system, and Google Play.

Among many other things, the manifest file is required to declare the following:

- The components of the app, including all activities, services, broadcast receivers, and content providers. Each component must define basic properties, such as the name of its Kotlin or Java class. It can also declare capabilities, such as which device configurations it can handle, and intent filters that describe how the component can be started. [Read more about app components](https://developer.android.com/guide/topics/manifest/manifest-intro#components) in a following section.
- The permissions that the app needs in order to access protected parts of the system or other apps. It also declares any permissions that other apps must have if they want to access content from this app. [Read more about permissions](https://developer.android.com/guide/topics/manifest/manifest-intro#perms) in a following section.
- The hardware and software features the app requires, which affects which devices can install the app from Google Play. [Read more about device compatibility](https://developer.android.com/guide/topics/manifest/manifest-intro#compatibility) in a following section.

If you're using [Android Studio](https://developer.android.com/studio) to build your app, the manifest file is created for you and most of the essential manifest elements are added as you build your app, especially when using [code templates](https://developer.android.com/studio/projects/templates).


## File features

The following sections describe how some of the most important characteristics of your app are reflected in the manifest file.

### App components

For each [app component](https://developer.android.com/guide/components/fundamentals#Components) that you create in your app, declare a corresponding XML element in the manifest file:

- [activity](https://developer.android.com/guide/topics/manifest/activity-element) for each subclass of [Activity](https://developer.android.com/reference/android/app/Activity)
- [service](https://developer.android.com/guide/topics/manifest/service-element) for each subclass of [Service](https://developer.android.com/reference/android/app/Service)
- [receiver](https://developer.android.com/guide/topics/manifest/receiver-element) for each subclass of [BroadcastReceiver](https://developer.android.com/reference/android/content/BroadcastReceiver)
- [provider](https://developer.android.com/guide/topics/manifest/provider-element) for each subclass of [ContentProvider](https://developer.android.com/reference/android/content/ContentProvider)

If you subclass any of these components without declaring it in the manifest file, the system can't start it.

Specify the name of your subclass with the `name` attribute, using the full package designation. For example, an `Activity` subclass is declared as follows:

```xml
<manifest ... >
    <application ... >
        <activity android:name="com.example.myapp.MainActivity" ... >
        </activity>
    </application>
</manifest>
```

However, if the first character in the `name` value is a period, the app's namespace, from the module-level `build.gradle` file's  [namespace](https://developer.android.com/reference/tools/gradle-api/7.1/com/android/build/api/variant/Variant#namespace) property, is prefixed to the name. For example, if the namespace is `"com.example.myapp"`, the following activity name resolves to `com.example.myapp.MainActivity`:

```xml
<manifest ... >
    <application ... >
        <activity android:name=".MainActivity" ... >
            ...
        </activity>
    </application>
</manifest>
```
For more information about setting the package name or namespace, see [Set the namespace](https://developer.android.com/studio/build/configure-app-module#set-namespace).

If you have app components that reside in sub-packages, such as in `com.example.myapp.purchases`, the `name` value must add the missing sub-package names, such as `".purchases.PayActivity"`, or use the fully qualified package name.

#### Intent filters

App activities, services, and broadcast receivers are activated by _intents_. An intent is a message defined by an [Intent](https://developer.android.com/reference/android/content/Intent) object that describes an action to perform, including the data to be acted on, the category of component that is expected to perform the action, and other instructions.

When an app issues an intent to the system, the system locates an app component that can handle the intent based on _intent filter_ declarations in each app's manifest file. The system launches an instance of the matching component and passes the `Intent` object to that component. If more than one app can handle the intent, then the user can select which app to use.

An app component can have any number of intent filters (defined with the [intent-filter](https://developer.android.com/guide/topics/manifest/intent-filter-element) element), each one describing a different capability of that component.

For more information, see the [Intents and Intent Filters](https://developer.android.com/guide/components/intents-filters) document.

#### Icons and labels

A number of manifest elements have `icon` and `label` attributes for displaying a small icon and a text label, respectively, to users for the corresponding app component.

In every case, the icon and label that are set in a parent element become the default `icon` and `label` value for all child elements. For example, the icon and label that are set in the [application](https://developer.android.com/guide/topics/manifest/application-element) element are the default icon and label for each of the app's components, such as all activities.

The icon and label that are set in a component's [intent-filter](https://developer.android.com/guide/topics/manifest/intent-filter-element) are shown to the user whenever that component is presented as an option to fulfill an intent. By default, this icon is inherited from whichever icon is declared for the parent component, either the [activity](https://developer.android.com/guide/topics/manifest/activity-element) or `<application>` element.

You might want to change the icon for an intent filter if it provides a unique action that you'd like to better indicate in the chooser dialog. For more information, see [Allow other apps to start your activity](https://developer.android.com/training/basics/intents/filters).

### Permissions

Android apps must request permission to access sensitive user data, such as contacts and SMS, or certain system features, such as the camera and internet access. Each permission is identified by a unique label. For example, an app that needs to send SMS messages must have the following line in the manifest:

```xml
<manifest ... >
    <uses-permission android:name="android.permission.SEND_SMS"/>
    ...
</manifest>
```

Beginning with Android 6.0 (API level 23), the user can approve or reject some app permissions at runtime. But no matter which Android version your app supports, you must declare all permission requests with a [uses-permission](https://developer.android.com/guide/topics/manifest/uses-permission-element) element in the manifest. If the permission is granted, the app is able to use the protected features. If not, its attempts to access those features fail.

Your app can also protect its own components with permissions. It can use any of the permissions that are defined by Android, as listed in [android.Manifest.permission](https://developer.android.com/reference/android/Manifest.permission), or a permission that's declared in another app. Your app can also define its own permissions. A new permission is declared with the [permission](https://developer.android.com/guide/topics/manifest/permission-element)element.

For more information, see [Permissions on Android](https://developer.android.com/guide/topics/permissions/overview).

### Device compatibility

The manifest file is also where you can declare what types of hardware or software features your app requires and, by extension, which types of devices your app is compatible with. Google Play Store doesn't let users install your app on devices that don't provide the features or system version that your app requires.

There are several manifest tags that define which devices your app is compatible with. The following are some of the most common.

#### uses-feature

The [`<uses-feature>`](https://developer.android.com/guide/topics/manifest/uses-feature-element) element lets you declare hardware and software features your app needs. For example, if your app can't achieve basic functionality on a device without a compass sensor, you can declare the compass sensor as required with the following manifest tag:

```xml
<manifest ... >
    <uses-feature android:name="android.hardware.sensor.compass"
                  android:required="true" />
    ...
</manifest>
```

#### uses-sdk

Each successive platform version often adds new APIs not available in the previous version. To indicate the minimum version with which your app is compatible, your manifest must include the [`<uses-sdk>`](https://developer.android.com/guide/topics/manifest/uses-sdk-element) tag and its [`minSdkVersion`](https://developer.android.com/guide/topics/manifest/uses-sdk-element#min) attribute.

However, be aware that attributes in the `<uses-sdk>` element are overridden by corresponding properties in the [`build.gradle`](https://developer.android.com/studio/build#build-files) file. So, if you're using Android Studio, specify the `minSdkVersion` and `targetSdkVersion` values there instead:

```kotlin
android {
    defaultConfig {
        applicationId = "com.example.myapp"

        // Defines the minimum API level required to run the app.
        minSdkVersion(21)

        // Specifies the API level used to test the app.
        targetSdkVersion(33)
        ...
    }
}
```


For more information about the `build.gradle` file, read about [how to configure your build](https://developer.android.com/studio/build).

To learn more about how to declare your app's support for different devices, see the [Device compatibility overview](https://developer.android.com/guide/practices/compatibility).

## File conventions

This section describes the conventions and rules that generally apply to all elements and attributes in the manifest file.

**Elements**

Only the [manifest](https://developer.android.com/guide/topics/manifest/manifest-element) and [application](https://developer.android.com/guide/topics/manifest/application-element) elements are required. They each must occur only once. Most of the other elements can occur zero or more times. However, some of them must be present to make the manifest file useful.

All values are set through attributes, not as character data within an element.

Elements at the same level are generally not ordered. For example, the [activity](https://developer.android.com/guide/topics/manifest/activity-element), [provider](https://developer.android.com/guide/topics/manifest/provider-element), and [service](https://developer.android.com/guide/topics/manifest/service-element) elements can be placed in any order. There are two key exceptions to this rule:

- An [activity-alias](https://developer.android.com/guide/topics/manifest/activity-alias-element) element must follow the `<activity>` for which it is an alias.
- The `<application>` element must be the last element inside the `<manifest>` element.

**Attributes**

Technically, all attributes are optional. However, many attributes must be specified so that an element can accomplish its purpose. For truly optional attributes, the [reference documentation](https://developer.android.com/guide/topics/manifest/manifest-intro#reference) indicates the default values.

Except for some attributes of the root [manifest](https://developer.android.com/guide/topics/manifest/manifest-element) element, all attribute names begin with an `android:` prefix, such as `android:alwaysRetainTaskState`. Because the prefix is universal, the documentation generally omits it when referring to attributes by name.

**Multiple values**

If more than one value can be specified, the element is almost always repeated, rather than multiple values being listed within a single element. For example, an intent filter can list several actions:

```xml
<intent-filter ... >
    <action android:name="android.intent.action.EDIT" />
    <action android:name="android.intent.action.INSERT" />
    <action android:name="android.intent.action.DELETE" />
    ...
</intent-filter>
```

**Resource values**

Some attributes have values that are displayed to users, such as the title for an activity or your app icon. The value for these attributes might differ based on the user's language or other device configurations (such as to provide a different icon size based on the device's pixel density), so the values should be set from a resource or theme, instead of hardcoded into the manifest file. The actual value can then change based on [alternative resources](https://developer.android.com/guide/topics/resources/providing-resources) that you provide for different device configurations.

Resources are expressed as values with the following format:

`"@[package:]type/name"`

You can omit the package name if the resource is provided by your app (including if it is provided by a library dependency, because [library resources are merged into yours](https://developer.android.com/studio/write/add-resources#resource_merging)). The only other valid package name is `android`, when you want to use a resource from the Android framework.

The type is a type of resource, such as [`string`](https://developer.android.com/guide/topics/resources/string-resource) or [`drawable`](https://developer.android.com/guide/topics/resources/drawable-resource), and the name is the name that identifies the specific resource. Here is an example:

```xml
<activity android:icon="@drawable/smallPic" ... >
```
For more information about how to add resources to your project, read [App resources overview](https://developer.android.com/guide/topics/resources/providing-resources).

To instead apply a value that's defined in a [theme](https://developer.android.com/guide/topics/ui/look-and-feel/themes), the first character must be `?` instead of `@`:

`"?[package:]type/name"`

**String values**

Where an attribute value is a string, use double backslashes (`\\`) to escape characters, such as `\\n` for a newline or `\\uxxxx` for a Unicode character.

## Example manifest file

The XML below is a simple example `AndroidManifest.xml` that declares two activities for the app.

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:versionCode="1"
    android:versionName="1.0">

    <!-- Beware that these values are overridden by the build.gradle file -->
    <uses-sdk android:minSdkVersion="15" android:targetSdkVersion="26" />

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:label="@string/app_name"
        android:supportsRtl="true"
        android:theme="@style/AppTheme">

        <!-- This name is resolved to com.example.myapp.MainActivity
             based on the namespace property in the build.gradle file -->
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <activity
            android:name=".DisplayMessageActivity"
            android:parentActivityName=".MainActivity" />
    </application>
</manifest>
```