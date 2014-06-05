Peticiones
==========

- [Autorización](#auth)
- [Límite de peticiones](#limits)
- [Tipos de datos](#data-types)

Las peticiones de esta API deben ser dirigidas a la URL base `https://sitio.gestii.com/api/v1/`, donde `sitio` representa el subdominio único que elegiste al crear tu cuenta de Gestii, y realizadas exclusivamente a través de HTTPS. Cualquier petición hecha sobre HTTP plano será rechazada.

Para indicar la intención de una petición, hacemos uso de los siguientes verbos estándares de HTTP:

- `GET` - Para listar un recurso o una colección de recursos.
- `POST` - Para crear un recurso o para métodos especiales.
- `PUT` - Para actualizar un recurso.
- `DELETE` - Para eliminar un recurso.

Si estás utilizando un cliente HTTP que no soporte métodos `PUT` o `DELETE`, puedes reemplazarlos haciendo una petición `POST` con el encabezado `X-HTTP-Method-Override` especificando el verbo deseado. Por ejemplo, para [eliminar un agente][eliminar agentes]:

	$ curl https://sitio.gestii.com/api/v1/agents/1?apikey=123456 \
		-X POST \
		-H "X-HTTP-Method-Override: DELETE"

~~~~auth
Autorización
------------

Todas las peticiones de la API de Gestii deben estar debidamente autenticadas con la API key de un admin y realizadas sobre HTTPS. Cualquier petición hecha sin una API key válida o sobre HTTP plano será rechazada.

Cada una de los métodos descritos en esta API —aun cuando no se indique explícitamente— recibe un parámetro adicional obligatorio llamado `apikey` que deberá contener una API key válida similar a la siguiente cadena:

	1c7a92ae351d4e21ebdfb897508f59d6

Una API key con todos los permisos será enviada a tu correo electrónico al crear tu cuenta de Gestii. Posteriormente podrás generar más llaves con distintos permisos desde la aplicación web o desde esta misma API.

~~~~limits
Límite de peticiones
--------------------

Esta API está limitada a 100 peticiones por minuto por cuenta, distribuídas entre todos los métodos y todas las API keys que se encuentren realizando peticiones. El estatus del límite actual se indica con los siguientes encabezados en todas las respuestas:

```
X-Rate-Limit: 100
X-Rate-Remaining: 99
X-Rate-Reset: 59
```

Donde `X-Rate-Limit` es el número máximo de peticiones por minuto que están disponibles para la cuenta, `X-Rate-Remaining` el número de peticiones restantes para el periodo actual y `X-Rate-Reset` el número de segundos restantes para que el contador vuelva a iniciar.

Si el limite se llegara a alcanzar, la API responderá con un código `429 Too Many Requests` y tu aplicación no deberá enviar más peticiones hasta que los segundos indicados en `X-Rate-Reset` hayan transcurrido.

~~~~data-types
Tipos de datos
--------------

Todos los atributos de objetos y parámetros de peticiones de esta API se encuentran representados por alguno de los siguientes tipos de datos:

Tipo         | Notas
-------------|-------------------------------------------------------------------------
Integer      | Números enteros de 4 bytes.
Boolean      | Uno de: `1` o `true` para verdadero, `0` o `false` para falso.
String       | Cadena de caracteres de hasta 255 caracteres.
Text         | Cadena de caracteres de hasta 65,535 caracteres.
CSV          | Listado de valores separados por comas.
Timestamp    | En formato [ISO 8601][] con la zona horaria configurada para la API key.
Date         | En formato `YYMMDD`.
DateTime     | En formato `YYMMDDHHmmSS` con modificadores de rangos.

~~~~type-basics
### Básicos

Los tipos de datos `Integer`, `Boolean`, `String` y `Text` son considerados tipos de datos básicos con los que muy probablemente te encuentras familiarizado. Los tipos `Integer` y `Boolean` no se diferencian de los conceptos de cualquier lenguaje de programación que los implemente. Los tipos `String` y `Text` son ambos cadenas de caracteres cuya única diferencia es la longitud máxima que aceptan.

~~~~type-csv
### CSV

El tipo de dato `CSV` se utiliza para representar listados en los parámetros de una petición y es siempre formateado como una cadena de valores separados por comas. Por ejemplo: `id,username,email` o inclusive solo `id`, que representaría una lista de un solo elemento.

Aunque esta API no impone un límite duro sobre la longitud de un parámetro tipo `CSV`, ten en cuenta que los métodos que pudieran requerir cadenas particularmente largas siempre serán `POST` o `PUT` y deberás tratar el parámetro como parte del cuerpo de la petición, no de la URL.

~~~~type-timestamp
### Timestamp

El tipo de dato `Timestamp` se utiliza para representar fechas en las respuestas de las peticiones y es siempre formateado de acuerdo al estándar internacional [ISO 8601][] incluyendo la zona horaria del [Admin][] para el cual haya sido generada la [API key][APIkeys] que está realizando la petición.

~~~~type-date
### Date

El tipo de dato `Date` se utiliza para representar una fecha en las peticiones con el formato `YYMMDD`. Este tipo de dato no acepta rangos.

~~~~type-datetime
### DateTime

El tipo de dato `DateTime` se utiliza para representar fechas en los parámetros de una petición. Es preferido sobre `Timestamp` para enviar fechas como parámetros debido a que cuenta con un formato más simple, además de soportar modificadores para crear rangos útiles para buscar.

El formato de un `DateTime` se compone de 12 dígitos, donde los primeros 6 representan la fecha (`YYMMDD`) y los restantes la hora (`HHmmSS`). Un ejemplo  de `DateTime` para el "8 de noviembre de 2013 a las 14:35:23" sería el siguiente: `131108143523`.

#### Rangos de fechas

Adicional a estos 12 dígitos, es posible agregar un modificador (opcional) para crear rangos de fechas, convirtiendo algo como `131108143523+1d` en un rango de `131108143523` a `131109143523`. Observa que al final de los dígitos de la hora ha sido agregado un `+1d` para indicar que el rango es a partir de esa fecha a un día despues. Esta característica también funciona para crear rangos restando el modificador, es decir: `131108143523-1d` se convierte en un rango de `131107143523` a `131108143523`. Observa que la fecha menor ha sido colocada al inicio del rango.

Los modificadores válidos para sumar o restar a un `DateTime` son los siguientes: `m` (minutos), `d` (días), `w` (semanas), `M` (meses). Cada uno de estos modificadores deberá ir antecedido por un signo de `+` o `-` para indicar la dirección del rango y un número entero positivo indicando el número de veces que se deberá extender dicho rango.

**Nota:** Observa que los minutos se distinguen de los meses al ser los primeros una `m` minúscula y los segundos una `M` mayúscula.

[Peticiones]: /API/peticiones
[Respuestas]: /API/respuestas
[Operaciones]: /API/operaciones
[Visitas]: /API/visitas
[Agentes]: /API/agentes
[Admins]: /API/admins
[Grupos]: /API/grupos
[Auxiliares]: /API/auxiliares
[Cookbook]: /API/cookbook
[Alertas]: /API/alertas
[Cuestionarios]: /API/cuestionarios

[Agente]: /API/agentes
[Admin]: /API/admins
[Grupo]: /API/grupos
[Form]: /API/#forms
[Alarma]: /API/#alarms
[Reporte]: /API/auxiliares#reports
[Visita]: /API/visitas

[Upload]: /API/auxiliares#uploads
[Extradata]: /API/auxiliares#extradata
[Feedback]: /API/auxiliares#feedbacks
[Location]: /API/auxiliares#locations
[Reporte]: /API/auxiliares#reports
[DelayedJob]: /API/auxiliares#jobs

[ISO 8601]: http://es.wikipedia.org/wiki/ISO_8601

[listar admins]: /API/admins#admins-list
[mostrar admins]: /API/admins#admins-show
[crear admins]: /API/admins#admins-create
[modificar admins]: /API/admins#admins-update
[eliminar admins]: /API/admins#admins-delete
[permisos admins]: /API/admins#admins-permissions
[objetos admins]: http://help.gestii.com:8080/API/admins#admins-objects
[APIkeys]: /API/admins#admins-apikeys

[listar agentes]: /API/agentes#agents-list
[mostrar agentes]: /API/agentes#agents-show
[crear agentes]: /API/agentes#agents-create
[modificar agentes]: /API/agentes#agents-update
[eliminar agentes]: /API/agentes#agents-delete
[encuestas agentes]: /API/agentes#agents-surveys
[localizar agentes]: /API/agentes#agents-location
[reporte agentes]: /API/agentes#agents-reports

[listar grupos]: /API/grupos#groups-list
[mostrar grupos]: /API/grupos#groups-show
[crear grupos]: /API/grupos#groups-create
[modificar grupos]: /API/grupos#groups-update
[eliminar grupos]: /API/grupos#groups-delete

[listar visitas]: /API/visitas#visits-list
[mostrar visitas]: /API/visitas#visits-show
[importar visitas]: /API/visitas#visits-upload
[cancelar visitas]: /API/visitas#visits-cancel
[eliminar visitas]: /API/visitas#visits-delete
[asignar visitas]: /API/visitas#visits-assign
[supervisar visitas]: /API/visitas#visits-supervise
[reporte visitas]: /API/visitas#visits-reports

[búsqueda]: /API/operaciones#searching
[ordenación]: /API/operaciones#sorting
[paginado]: /API/operaciones#pagination
[extracción]: /API/operaciones#extraction
[vinculación]: /API/operaciones#embedding

[autorización]: /API/peticiones#auth
[límite de peticiones]: /API/peticiones#limits
[tipos de datos]: /API/peticiones#data-types
[datetime]: /API/peticiones#type-datetime
