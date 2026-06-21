import io.github.cdimascio.dotenv.Dotenv

val dotenv = Dotenv.configure()
    .directory(rootDir.parentFile.absolutePath)
    .ignoreIfMissing()
    .load()

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.connectfeso"
    compileSdk = 35 // Atualizado para 35 conforme exigido pelos plugins
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.connectfeso"
        minSdk = flutter.minSdkVersion
        targetSdk = 35 // Atualizado para 35 para acompanhar o compileSdk
        versionCode = 1
        versionName = "1.0"

        val googleMapsKey = dotenv["GOOGLE_MAPS_API_KEY"]
            ?: throw GradleException("GOOGLE_MAPS_API_KEY não encontrada no .env")

        resValue("string", "GOOGLE_MAPS_API_KEY", googleMapsKey)
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
