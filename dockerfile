from mcr.microsoft.com/dotnet/core/sdk:3.1 as build
workdir /choosewine
expose 80
expose 443
copy *.csproj .
run dotnet restore
copy . .
run dotnet publish -c Release -o out
from mcr.microsoft.com/dotnet/core/aspnet:3.1
copy --from=build ./choosewine/out .
entrypoint ["dotnet", "choosewine.dll"]