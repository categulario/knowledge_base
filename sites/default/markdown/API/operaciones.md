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
- `429 Too Many Requests` - La petición no ha sido procesada debido a que se ha alcanzado el [límite](#limits) permitido.
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
[Agente]: #agents
[Admin]: #admins
[Grupo]: #groups
[Form]: #forms
[Alarma]: #alarms
[Reporte]: #reports
[Visita]: #visits
[Upload]: #uploads
[Extradata]: #extradata
[Feedback]: #feedbacks
[Location]: #locations
[Reporte]: #reports
[DelayedJob]: #jobs

[ISO 8601]: http://es.wikipedia.org/wiki/ISO_8601

[búsqueda]: #searching
[ordenación]: #sorting
[paginado]: #pagination
[extracción]: #extraction
[vinculación]: #embedding
