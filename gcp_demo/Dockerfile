#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["gcp_demo/gcp_demo.csproj", "gcp_demo/"]
RUN dotnet restore "gcp_demo/gcp_demo.csproj"
COPY . .
WORKDIR "/src/gcp_demo"
RUN dotnet build "gcp_demo.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "gcp_demo.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "gcp_demo.dll"]










