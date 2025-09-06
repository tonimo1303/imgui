project "ImGui"
    kind "StaticLib"
    staticruntime "off"

    language "c++"
    cppdialect "c++17"

    targetdir ("Builds/" .. outputdir .. "Linked/")
    objdir ("Builds/" .. outputdir .. "Intermediate/")

    files
    {
        "./premake5.lua",
        "./*.h",
        "./*.c",
    }
    
    if (os.target() == "windows") then
        files
        {
            "./backends/imgui_impl_win32.h",
            "./backends/imgui_impl_win32.cpp"
        }
    end
    
    if (os.target() == "macosx") then
        files
        {
            "./backends/imgui_impl_osx.h",
            "./backends/imgui_impl_osx.mm"
        }
    end
    
    for _, renderer in ipairs(renderers) do
        if renderer == "d3d12" then
            files
            {
                "./backends/imgui_impl_dx12.h",
                "./backends/imgui_impl_dx12.cpp"
            }
        elseif renderer == "vulkan" then
            files
            {
                "./backends/imgui_impl_vulkan.h",
                "./backends/imgui_impl_vulkan.cpp"
            }
        elseif renderer == "metal" then
            files
            {
                "./backends/imgui_impl_metal.h",
                "./backends/imgui_impl_metal.mm"
            }
        end
    end

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Development"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        symbols "off"
