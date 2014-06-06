Respuestas
==========

Todas las respuestas de esta API son cadenas codificadas en [JSON](http://es.wikipedia.org/wiki/JSON) y devuelven en los encabezados un código HTTP indicando si la petición tuvo éxito o falló. En caso de éxito, la respuesta contendrá alguno de los códigos siguientes:

- `200 OK` - Petición exitosa. Se devuelve el resultado de la petición en la respuesta.
- `201 Created` - Recurso creado. Se devuelve el recurso en la respuesta.
- `202 Accepted` - Petición aceptada para procesarse. Se devuelve información para monitorear su progreso.
- `204 No Content` - Petición exitosa. No es necesario devolver más información.

Por otro lado, en caso de error cualquier petición puede devolver alguno de los siguientes códigos:

- `400 Bad Request` - La petición contiene parámetros erroneos o falló alguna validación.
- `401 Unauthorized` - No se ha especificado una API key válida.
- `403 Forbidden` - La API key especificada no cuenta con permisos para ejecutar el método llamado.
- `404 Not Found` - El recurso solicitado no ha sido encontrado.
- `429 Too Many Requests` - La petición no ha sido procesada debido a que se ha alcanzado el [límite][límite de peticiones] permitido.
- `500 Internal Server Error` - Ha ocurrido un error interno del servidor.

Toda la serie de errores `4XX` devuelve en el cuerpo un objeto JSON con la siguiente estructura:

```json
{
	"message": "El recurso no ha sido encontrado"
}
```

En caso de que la petición devuelva un código `400 Bad Request`, es posible que existan errores adicionales si lo provocó una validación fallida:

```json
{
	"message": "Algunas validaciones han fallado",
	"errors": [
		"username": [
			"El nombre de usuario se encuentra en uso"
		],
		"password": [
			"La contraseña debe tener al menos 5 caracteres",
			"La contraseña debe tener al menos un número"
		]
	]
}
```

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
