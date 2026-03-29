allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // As versões agora são gerenciadas preferencialmente no settings.gradle.kts
        // Mas mantemos suporte para plugins que ainda dependem do buildscript se necessário.
        classpath("io.github.cdimascio:dotenv-kotlin:6.3.0")
    }
}

plugins {
    // Estes IDs devem coincidir com os definidos no settings.gradle.kts
    id("com.android.application") apply false
    id("com.google.gms.google-services") apply false
    id("org.jetbrains.kotlin.android") apply false
}
