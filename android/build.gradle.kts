// Top-level build.gradle.kts



buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // ✅ Needed for Firebase and Google Services
        classpath("com.google.gms:google-services:4.3.15")
    }
}

plugins {
    // Use the same version Gradle already loaded (8.1.0)
    id("com.android.application") version "8.9.1" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
    id("com.google.gms.google-services") version "4.4.2" apply false
    
    
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = file("../build")
subprojects {
    project.buildDir = file("${rootProject.buildDir}/${project.name}")
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}

