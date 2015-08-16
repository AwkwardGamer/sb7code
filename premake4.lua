newoption {
  trigger = "shared-glfw",
  description = "GLFW will be built as a shared library"
}

solution "Superbible7"
  configurations { "debug", "release", "releaseWithDbg" }
  
  dofile ("examples.lua")
  
  --include "extern/glfw-3.0.4"
  
  project "sb7"
    kind "StaticLib"
    language "C++"
    location "build"
    includedirs { "include", "extern/glfw-3.0.4/include" }
    files { "src/sb7/*.cpp", "src/sb7/*.c" }
    targetdir "lib"

  configuration "debug"
    targetsuffix "_d"
    flags "Symbols"
  
  configuration "release"
    flags "Optimize"
    
  configuration { "releaseWithDbg" }
    flags { "Optimize", "Symbols" }
    targetsuffix "_d"
      
  configuration "not vs"
    buildoptions { "-std=c++11" }
    
  for ind, example in pairs(examples) do
    project ("" .. example)
      kind "WindowedApp"
      language "C++"
      location "build"
      includedirs { "include", "extern/glfw-3.0.4/include" }
      targetdir "bin"
      files ("src/" .. example .. "/*.cpp")
      links { "sb7", "glfw3" }

      configuration "debug"
        flags "Symbols"
        
      configuration "release"
        flags "Optimize"
    
      configuration { "releaseWithDbg" }
        flags { "Optimize", "Symbols" }
        targetsuffix "_d"
      
      configuration "not vs"
        buildoptions { "-std=c++11" }
        if example == "ompparticles" or example == "pmbfractal" then
          buildoptions "-fopenmp"
          linkoptions "-fopenmp"
        end
        
      configuration "windows"
        links { "gdi32", "opengl32" }
        
      configuration "linux"
        links { "X11", "Xrandr", "Xinerama", "Xi", "Xxf86vm", "Xcursor", "GL", "rt", "dl" }
  end