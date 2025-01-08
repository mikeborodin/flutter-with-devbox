let javaHome = $"($env.DEVBOX_PROJECT_ROOT)/.devbox/nix/profile/default/Contents/Home"
$env.JAVA_HOME = $javaHome

def build_android [type, buildNumber] {
  (
    flutter build $type
      --release 
      --target lib/main.dart 
      --build-number=($buildNumber)  
      --dart-define=NETWORK_DEBUGGING_ENABLED=true
  )
}

def analyze [] {
  flutter analyze
}

def build_ios [buildNumber] {
 $env.CC = "/usr/bin/clang"
 $env.LD = "/usr/bin/clang"
  (
    flutter build ipa 
      --release 
      --target lib/main.dart 
      --build-number=($buildNumber)  
      --export-options-plist ios/signing/ipaExportOptionsProd.plist 
      --dart-define=NETWORK_DEBUGGING_ENABLED=true
  )
} 

def build_all [buildNumber:number] {
   build_ios $buildNumber
   build_android apk $buildNumber
}



