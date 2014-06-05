Auxiliares
==================

- [Upload](#uploads)
- [Extradata](#extradata)
- [Feedback](#feedbacks)
- [Location](#locations)
- [Reporte](#reports)
- [DelayedJob](#jobs)

Los auxiliares son objetos de la API que no pueden ser consultados si no es mediante alguno de los métodos de los objetos principales. En general, se utilizan para representar información que no puede ser modificada.

~~~~uploads
Upload
------

Un upload representa un archivo de importación de visitas. En la API un upload se encuentra representado por un objeto con la siguiente estructura:

```json
{
	"id": 1,
	"name": "Visitas 01 enero 2014.csv",
	"status": 101,
	"processed": 1000,
	"geocoded": 500,
	"checksum": "dd57cb7057dbe4de7645bd273198aa92",
	"created_at": "2014-01-01T14:00:00Z"
}
```

Atributo       | Tipo      | Notas
---------------|-----------|-------------------------------------------------
id             | Integer   | 
name           | String    | 
status         | Integer   | Ver el [diccionario de status](#uploads-status).
processed      | Integer   | Número de visitas procesadas.
geocoded       | Integer   | Número de visitas geolocalizadas.
checksum       | String    | 
created_at     | Timestamp | 

El contador `processed` indica el número de visitas que se han leído correctamente del archivo. El contador `geocoded`, por su parte, comienza una vez que el anterior ha finalizado e indica el número de visitas que han geolocalizado con éxito. Es importante recalcar que la geolocalización no comienza hasta que todas las visitas del archivo hayan sido procesadas sin ningún error.

~~~~uploads-codes
**Diccionario de estatus:**

Status | Mensaje
-------|--------------------------------------------------------------------------------------------
100    | Esperando por una instancia de procesamiento.
101    | El archivo está siendo procesado.
102    | Proceso finalizado sin errores, las visitas han sido creadas.
200    | La estructura del archivo no corresponde a la requerida por el layout.
203    | Algunos encabezados requeridos no se han encontrado.
204    | Un archivo exactamente igual se está siendo procesado.
300    | Los errores se indican en archivo (ver [descargar errores de importación](#visits-errors)).

**Nota:** Los códigos `1XX` indican que ningun error ha sido detectado, los `2XX` que se han encontrado errores globales y el `300` que han ocurrido múltiples errores distintos y es necesario descargar un archivo con la descripción de cada uno de ellos.

~~~~extradata
Extradata
---------

Un extradata representa un campo de la información precargada para una visita durante la importación. En la API un extradata se encuentra representado por un objeto con la siguiente estructura:

```json
{
	"caption": "Nombre",
	"value": "Han Solo"
}
```

Atributo       | Tipo      | Notas
---------------|-----------|----------------------------------------------------
caption        | String    | El nombre de la columna del archivo de importación.
value          | String    | 

~~~~feedbacks
Feedback
--------

Un feedback representa un campo de la información capturada para una visita al momento de su realización. En la API un feedback se encuentra representado por un objeto con la siguiente estructura:

```json
{
	"varname": "color",
	"caption": "Color",
	"value": "Rojo"
}
```

Atributo       | Tipo      | Notas
---------------|-----------|--------------------------------------------------
varname        | String    | La variable del campo del [cuestionario][Cuestionarios].
caption        | String    | La etiqueta del campo del [cuestionario][Cuestionarios].
value          | String    | 

~~~~locations
Location
--------

Una location representa un punto de ubicación geográfica y un evento de uno de los [agentes][Agentes]. En la API una location se encuentra representada por un objeto con la siguiente estructura:

```json
{
	"id": 1,
	"agent_id": 1,
	"event": 1,
	"latitude": 19.492316,
	"longitude": -99.234433,
	"accuracy": 10,
	"created_at": "2014-01-01T14:00:00Z"
}
```

Atributo       | Tipo      | Notas
---------------|-----------|----------------------------------------------------
id             | Integer   | 
agent_id       | Integer   | 
event          | Integer   | Ver el [diccionario de eventos](#locations-events).
latitude       | Decimal   | 
longitude      | Decimal   | 
accuracy       | Integer   | Precisión en metros de la localización.
created_at     | Timestamp | 

~~~~locations-events
**Diccionario de eventos:**

Evento | Mensaje
-------|-----------------------------
0      | Inicio de sesión.
1      | Cierre de sesión por agente.
2      | Solicitud de visitas.
3      | Aceptación de visitas.
4      | Notificación de ubicación.
5      | Envío de resultado de visita.
6      | Solicitud de cuestionario.

~~~~reports
Reporte
-------

Un reporte representa un archivo comprimido que puede ser generado y descargado con información de [visitas][Visitas], [agentes][Agentes] y demás objetos. En la API un reporte se encuentra representado por un objeto con la siguiente estructura:


```json
{
	"generator": "VISITS",
	"name": "Reporte PDF",
	"description": "Reporte en formato PDF estándar",
}
```

Atributo       | Tipo      | Notas
---------------|-----------|------
generator      | String    | 
name           | String    | 
description    | String    | 

~~~~jobs
DelayedJob
----------

Un delayed job es un proceso que se ejecuta de forma asíncrona y en background en Gestii. Este tipo de operación se utiliza especialmente para realizar tareas que se espera que no terminen inmediatamente pero de las cuáles se necesita proveer un método de monitoreo de su finalización. En la API un delayed job se encuentra representado por un objeto con la siguiente estructura:


```json
{
	"id": "b9iLXiAa",
	"status": 0
}
```

Atributo       | Tipo      | Notas
---------------|-----------|--------------------------------------------
id             | Integer   | 
status         | Integer   | Uno de: `0` (procesando), `1` (finalizado).

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
