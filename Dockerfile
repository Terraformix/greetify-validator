FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 5194
EXPOSE 7132

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["GreetifyValidation.csproj", "./"]
RUN dotnet restore "GreetifyValidation.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "GreetifyValidation.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "GreetifyValidation.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

ENV ASPNETCORE_URLS="http://+:5194"
#ENV ASPNETCORE_URLS="http://+:5194;https://+:7132"
#ENV ASPNETCORE_HTTPS_PORTS=7132

ENTRYPOINT ["dotnet", "GreetifyValidation.dll"]
