# استخدم صورة SDK لبناء المشروع
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# انسخ ملفات المشروع
COPY . ./

# Restore dependencies
RUN dotnet restore

# Build and publish
RUN dotnet publish -c Release -o out

# صورة runtime فقط (أصغر وأسرع)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# انسخ الملفات المنشورة من مرحلة البناء
COPY --from=build /app/out ./

# اسمع على البورت 80
EXPOSE 80

# أمر التشغيل
ENTRYPOINT ["dotnet", "BankSystem.dll"]
