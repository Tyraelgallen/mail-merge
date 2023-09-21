String defaultSubdominio(String? subd) {
  String subdominio = subd ?? "";
  if (subdominio != "") subdominio = subdominio + ".";
  return subdominio;
}

String crearCarpeta({required String domin, String? subd}) {
  String result;
  String subdominio = defaultSubdominio(subd);
  result = "mkdir -p /var/www/$subdominio$domin";
  return result;
}

String cambiarPermisos({required String domin, String? subd}) {
  String result;
  String subdominio = defaultSubdominio(subd);
  result = "chown -R www-data:www-data var/www/$subdominio$domin";

  return result;
}

String crearHTML({required String domin, String? subd}) {
  String result;
  String subdominio = defaultSubdominio(subd);
  result = """tee /var/www/$subdominio$domin/index.html<<EOF
<html>
    <head>
        <title>$subdominio$domin</title>
    </head>
    <body style="background-color: #deeaee;">
        <h1> Welcome to:</h1>
<p><b> main </b>$subdominio$domin!!!!</p>
    </body>
</html>
EOF""";
  return result;
}

String crearSitio({required String domin, String? subd}) {
  String result;
  String subdominio = defaultSubdominio(subd);
  result = """tee /etc/apache2/sites-available/$subdominio$domin.conf<<EOF
  <VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName $subdominio$domin
    ServerAlias www.$subdominio$domin
    DocumentRoot /var/www/$subdominio$domin
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
  </VirtualHost> 
  EOF""";
  return result;
}

String habilitarSitio({required String domin, String? subd}) {
  String result;
  String subdominio = defaultSubdominio(subd);
  result = "a2ensite $subdominio$domin.conf";
  return result;
}

String textosExplicativos(int index) {
  switch (index) {
    case 1:
      return "Este comando te permite crear una carpeta en tu directorio www para almacenar tu pagina web";
    case 2:
      return "Cambia los permisos de administrador de la carpeta previamente creada";
    case 3:
      return "Crea un archivo html basico para realizar una prueba de funcionamiento de la página";
    case 4:
      return "Genera un archivo .conf en el directorio sites-available que determina que la página esta disponible";
    case 5:
      return "Habilita la página a todo publico";
  }

  return "";
}
