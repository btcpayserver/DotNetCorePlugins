rm "..\..\.build\bin\McMaster.NETCore.Plugins\Release\" -Recurse -Force
rm "..\..\.build\bin\McMaster.NETCore.Plugins.Mvc\Release\" -Recurse -Force

dotnet pack --configuration Release --include-symbols -p:SymbolPackageFormat=snupkg
$package=(ls ..\..\.build\bin\McMaster.NETCore.Plugins\Release\*.nupkg).FullName
dotnet nuget push $package --source "https://api.nuget.org/v3/index.json"
$ver = ((ls ..\..\.build\bin\McMaster.NETCore.Plugins\Release\*.nupkg)[0].Name -replace '.*(\d+\.\d+\.\d+)\.nupkg','$1')


cd ..\Plugins.Mvc
dotnet pack --configuration Release --include-symbols -p:SymbolPackageFormat=snupkg
$package=(ls ..\..\.build\bin\McMaster.NETCore.Plugins.Mvc\Release\*.nupkg).FullName
dotnet nuget push $package --source "https://api.nuget.org/v3/index.json"


git tag -a "btcpay/v$ver" -m "btcpay/v$ver"
git push origin "btcpay/v$ver"
