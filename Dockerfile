#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["TestAuth0/TestAuth0.csproj", "TestAuth0/"]
COPY ["Auth0.AspNetCore.Authentication/Auth0.AspNetCore.Authentication.csproj", "Auth0.AspNetCore.Authentication/"]
RUN dotnet restore "Auth0.AspNetCore.Authentication/Auth0.AspNetCore.Authentication.csproj"
RUN dotnet restore "TestAuth0/TestAuth0.csproj"
COPY . .
WORKDIR /src/TestAuth0
RUN dotnet build "TestAuth0.csproj" -c Release -o /app/build

FROM build AS publish
WORKDIR /src/TestAuth0
RUN dotnet publish "TestAuth0.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "TestAuth0.dll"]
# Use the following instead for Heroku
CMD ASPNETCORE_URLS=http://*:$PORT dotnet TestAuth0.dll
