project "glfw3"
  language "C"
  files "src/*.c"
  includedirs { "include", "deps" }
  location "build"
  defines "_GLFW_USE_OPENGL"
  targetdir "../../lib"
  
  configuration "not shared-glfw"
    kind "StaticLib"
  
  configuration "shared-glfw"
    kind "SharedLib"
    defines { "_GLFW_BUILD_DLL", "_GLFW_NO_DLOAD_WINMM" }
    
  configuration "debug"
    targetsuffix "_d"
    flags "Symbols"
  
  configuration "release"
    defines "NDEBUG"
    flags "Optimize"
    
  configuration { "releaseWithDbg" }
    flags { "Optimize", "Symbols" }
    targetsuffix "_d"
    
  configuration "windows"
    excludes { "src/cocoa*", "src/x11*", "src/egl*", "src/glx*" }
    defines { "_GLFW_WIN32", "_GLFW_WGL" }
    links { "winmm", "opengl32", "gdi32" }
    
  configuration "linux"
    excludes { "src/cocoa*", "src/win32*", "src/wgl*", "src/egl*" }
    defines { "_GLFW_X11", "_GLFW_GLX", "_GLFW_HAS_GLXGETPROCADDRESS"  }
    links { "X11", "pthread", "Xrandr",  "Xi",  "Xxf86vm",  "rt",  "m",  "GL" }
    
  configuration "vs"
    defines "_CRT_SECURE_NO_WARNINGS"
    
  configuration "not vs"
    buildoptions{ "-w", "-fvisibility=hidden" }