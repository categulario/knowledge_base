Auxiliares
==================

- [Upload](#uploads)
- [Extradata](#extradata)
- [Feedback](#feedbacks)
- [Location](#locations)
- [Reporte](#reports)
- [Tasks](#tasks)

Los auxiliares son objetos de la API que no pueden ser consultados si no es mediante alguno de los métodos de los objetos principales. En general, se utilizan para representar información que no puede ser modificada.

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
	"visit_id": 1,
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
visit_id       | Integer   | 
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
	"id": 1,
	"generator": "VISITS",
	"name": "Reporte PDF",
	"description": "Reporte en formato PDF estándar",
	"params": [ ]
}
```

Atributo       | Tipo      | Notas
---------------|-----------|---------------------------------
id             | Integer   | 
generator      | String    | 
name           | String    | 
description    | String    | 
params         | [Params]  | Un array de objetos tipo params.

~~~~params
Params
------
Un param es un parámetro que tiene que recibir un reporte para generarse. Tiene la siguiente estructura:

````json
{
	"name": "addimages",
	"datatype": "bool",
	"value": "true"
}
````

Atributo       | Tipo      | Notas
---------------|-----------|---------------------------
name           | String    | 
datatype       | String    | 
value          | String    | Este atributo es opcional.

Al solicitar un reporte, el cuerpo de la petición debe contener los parámetros especificados con el mismo nombre.

~~~~tasks
Tasks
-----

Un task es un proceso que se ejecuta de forma asíncrona y en background en Gestii. Este tipo de operación se utiliza especialmente para realizar tareas que se espera que no terminen inmediatamente pero de las cuáles se necesita proveer un método de monitoreo de su finalización. En la API un task se encuentra representado por un objeto con la siguiente estructura:


```json
{
	"id": 1,
	"caption": "Report: test1.pdf",
	"status": 3,
	"progress": 89,
	"message": "",
	"created_at": "2014-06-05T03:37:33+0000",
	"admin_id": 1,
	"item_id": 1,
	"type":"report"
}
```

Atributo       | Tipo      | Notas
---------------|-----------|----------------------------------------------------------------------------------------------------------------------------
id             | Integer   | 
caption        | String    | Título del task
status         | Integer   | Uno de: `0` (esperando), `1` (preprocesando), `2` (procesando), `3` (terminado), `4` o `5` (error), `6` (error de sistema).
progress       | Integer   | Entero del 0 al 100.
message        | String    | Mensaje de error, en caso de aplicar.
created_at     | DateTime  |
admin_id       | Integer   | id del administrador que mandó el task.
item_id        | Integer   | id del objeto relacionado (upload, reporte).
type           | String    | Uno de: `upload`, `report`.

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
[Cuestionarios]: /cuestionarios

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
[DelayedJob]: /API/auxiliares#tasks
[Task]: /API/auxiliares#tasks

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
