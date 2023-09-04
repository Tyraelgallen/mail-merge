String defaultSubdominio(String? subd) {
  String subdominio = subd ?? "";
  if (subdominio != "") subdominio = subdominio + ".";
  return subdominio;
}

String crearCarpeta({required String domin, String? subd}) {
  String result;
  String subdominio = defaultSubdominio(subd);
  result = "mkdir -p /var/www/$subdominio$domin.com";
  return result;
}

String cambiarPermisos({required String domin, String? subd}) {
  String result;
  String subdominio = defaultSubdominio(subd);
  result = "chown -R www-data:www-data var/www/$subdominio$domin.com";

  return result;
}

String crearHTML({required String domin, String? subd}) {
  String result;
  String subdominio = defaultSubdominio(subd);
  result = """tee /var/www/$subdominio$domin.com/index.html<<EOF
<html>
    <head>
        <title>$subdominio$domin.com</title>
    </head>
    <body style="background-color: #deeaee;">
        <h1> Welcome to:</h1>
<p><b> main </b>$subdominio$domin.com!!!!</p>
    </body>
</html>
EOF""";
  return result;
}

String crearSitio({required String domin, String? subd}) {
  String result;
  String subdominio = defaultSubdominio(subd);
  result = """tee /etc/apache2/sites-available/$subdominio$domin.com.conf<<EOF
  <VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName $subdominio$domin.com
    ServerAlias www.$subdominio$domin.com
    DocumentRoot /var/www/$subdominio$domin.com
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
  </VirtualHost> 
  EOF""";
  return result;
}

String habilitarSitio({required String domin, String? subd}) {
  String result;
  String subdominio = defaultSubdominio(subd);
  result = "a2ensite $subdominio$domin.com.conf";
  return result;
}

String textosExplicativos(int index) {
  switch (index) {
    case 1:
      return "Este comando te permite crear una carpeta en tu directorio www para almacenar tu pagina web";
  }

  return "";
}
