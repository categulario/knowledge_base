API REST v1
===========

Gestii es una solución completamente hosteada que te permite tener bajo control la operación de tus agentes de campo y, por supuesto, de toda tu información. Es por eso que proveemos una API [REST](http://es.wikipedia.org/wiki/Representational_State_Transfer) construída con principios pragmáticos que la hacen muy sencilla de consultar.

Nuestra API utiliza todas las ventajas del protocolo HTTP, desde las comunicaciones seguras hasta los códigos de respuesta, por lo que cualquier cliente o componente HTTP debería ser capaz de comunicarse sin problemas con ella.
Vínculos Rápidos
----------------

Contenido                  | Notas
---------------------------|-------------------------------------------------------------------------------------------
[Peticiones][Peticiones]   | Descripción de las peticiones, autorización, límites y tipos de datos.
[Respuestas][Respuestas]   | Descripción de las respuestas y códigos de éxito y error.
[Operaciones][Operaciones] | Instrucciones para buscar, contar, ordenar, paginar y reducir el tamaño de las peticiones.
[Visitas][Visitas]         | Administración de visitas —como órdenes de trabajo, encuestas, cuentas por cobrar—.
[Agentes][Agentes]         | Administración de usuarios que se conectan desde las apps móviles.
[Admins][Admins]           | Administración de usuarios que se conectan desde la interfaz web.
[Grupos][Grupos]           | Administración de divisiones organizacionales —como oficinas, sucursales, áreas—.
[Auxiliares][Auxiliares]   | Descripción de objetos auxiliares de al API —Uploads, Extradata, Feedbacks—.
[Cookbook][Cookbook]       | Recetas rápidas y deliciosas para realizar acciones comunes.

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
