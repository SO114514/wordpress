# Download ubi9 image from registry.access.redhat.com
FROM registry.access.redhat.com/ubi9/ubi:latest

# Download the necessary components
RUN dnf install -y \
        php \
        php-mysqlnd \
        php-json \
        php-curl \
        php-gd \
        php-mbstring \
        php-xml \
        php-zip \
        httpd \
        tar \
        wget\
        unzip \
    && dnf clean all

# Install and place the WordPress
RUN wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip && unzip /tmp/wordpress.zip -d /var/www/html && rm /tmp/wordpress.zip
RUN chown -R 1001:0 /var/www/html && chmod -R g+w /var/www/html

WORKDIR /vat/www/html/wordpress/

# Open Port
EXPOSE 8080

# Update configuration Apache
RUN sed -i 's/^Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf

# While start up and running the container
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html/wordpress/"]
