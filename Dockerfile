FROM php:7.4-fpm

RUN apt-get update && apt-get install -y nginx supervisor libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip git && docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install -j$(nproc) pdo pdo_mysql gd zip opcache && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY . /var/www/crmeb
WORKDIR /var/www/crmeb
RUN composer install --no-dev --optimize-autoloader

EXPOSE 80
CMD ["php-fpm"]