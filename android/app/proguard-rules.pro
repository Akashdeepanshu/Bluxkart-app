# Recommended ProGuard Rules for Flutter
# Keep annotation classes (Razorpay related issue)
-keep @interface proguard.annotation.Keep
-keep @interface proguard.annotation.KeepClassMembers

# Keep classes for R8
-keep class com.razorpay.** { *; }
-keep class * implements android.os.Parcelable { *; }

# General Flutter & AndroidX ProGuard Rules
-ignorewarnings
-keep class io.flutter.** { *; }
-keep class androidx.** { *; }
-keep class com.google.** { *; }
-keep class com.facebook.** { *; }
-keep class com.firebase.** { *; }
-keep class com.razorpay.** { *; }
-keepclassmembers enum * { *; }

# Keep Kotlin metadata
-keep class kotlin.Metadata { *; }

# Keep Gson (if used)
-keep class com.google.gson.** { *; }

# Keep Retrofit (if used)
-keep class retrofit2.** { *; }
