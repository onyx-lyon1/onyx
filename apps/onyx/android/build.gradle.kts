allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir = rootProject.layout.projectDirectory.dir("../../build")
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    project.layout.buildDirectory.value(rootProject.layout.projectDirectory.dir("../../build/${project.name}"))
}
// evaluationDependsOn is managed automatically by the new Flutter Gradle Plugin.

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
