# Weblogic Container

- Descargar JAVA 8 jdk-8u301-linux-x64.rpm.

- Descargar Oracle WebLogic 12c Generic installer fmw_12.2.1.3.0_wls.jar.

- Los archivos descargados colocarlos en la carpeta raiz donde se clono el repositorio.

## Compilación

Ejecutar el comando para construir la imagen

```bash
docker build --tag weblogic-container:1.0.0 .
```

## Uso

Ejecutar el comando para utilizar la imagen recien creada.

```bash
docker run -d -p 7001:7001 --name weblogic-server weblogic-container
```

### Credenciales

Las credeciales por defecto son las siguientes

- Username: weblogic
- Password: weblogic123