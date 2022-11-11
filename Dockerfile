FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 5255

ENV ASPNETCORE_URLS=http://+:5255

# Cria um usuário não root com um UID explícito e adiciona a permissão para acessar a pasta /app
# a documentação está disponível em https://aka.ms/vscode-docker-dotnet-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["CSharp-EmployeeCrud.csproj", "./"]
RUN dotnet restore "CSharp-EmployeeCrud.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "CSharp-EmployeeCrud.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "CSharp-EmployeeCrud.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CSharp-EmployeeCrud.dll"]
