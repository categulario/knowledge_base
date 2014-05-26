# Propiedades

Todos los campos tienen un conjunto de propiedades que usted puede editar.

<dl>
  <dt><strong>Etiqueta</strong></dt>
  <dd>Es el texto que se muestra junto con el campo.</dd>
  <dt><strong>Nombre de la variable</strong></dt>
  <dd>Es el nombre que aparecerá en los reportes y dependencias.</dd>
  <dt><strong>Requerido</strong></dt>
  <dd>Si está activado, no se puede completar el cuestionario sin rellenar
  este campo.</dd>
  <dt><strong>Dependencias</strong></dt>
  <dd>Delimitan las condiciones en las cuales se debería mostrar este campo.
  Se describen con detalle en [su propio artículo](dependencias).</dd>
  <dt><strong>Nombre de la variable</strong></dt>
  <dd>Es el nombre que aparecerá en los reportes y dependencias.</dd>
  <dt><strong>Extra</strong></dt>
  <dd>Marca si este campo se debería guardar en uno de los campos Extra.
  Se describen con detalle en [su propio artículo](extras).</dd>
</dl>

Los distintos campos también tienen propiedades particulares para cada uno.

### Texto

<dl>
  <dt><strong>Tipo</strong></dt>
  <dd>Permite restringir el texto que se puede introducir a texto
  alfanumérico, números decimales o números enteros.</dd>
  <dt><strong>Valor por defecto</strong></dt>
  <dd>El texto que está inicialmente en el campo.</dd>
  <dt><strong>Longitud mínima</strong></dt>
  <dd>Cantidad de caracteres que necesitan haber por lo menos.</dd>
  <dt><strong>Longitud máxima</strong></dt>
  <dd>Cantidad de caracteres que se pueden introducir.</dd>
</dl>

### Verdadero/Falso

<dl>
  <dt><strong>Seleccionado</strong></dt>
  <dd>Si el campo estará seleccionado inicialmente.</dd>
</dl>

### Listas desplegables

<dl>
  <dt><strong>Opciones</strong></dt>
  <dd>Las opciones que se despliegan en la lista.
  Para agregar nuevas opciones, rellene el campo de Etiqueta y Valor
  y seleccione el botón de Agregar. Etiqueta es lo que se despliega
  en la lista, mientras que Valor es lo que se guarda como la respuesta
  de ese campo.</dd>
</dl>

### Fecha

<dl>
  <dt><strong>Límite inferior</strong></dt>
  <dd>Si está activado, sólo deja poner fechas en ese rango hacia
  atrás de la fecha en que se abrió el cuestionario. Por ejemplo, si
  el valor es -1 sólo permite introducir fechas a partir de ayer.</dd>
  <dt><strong>Límite superior</strong></dt>
  <dd>Si está activado, delimita la fecha a partir de la cual ya no se pueden introducir fechas. Por ejemplo, si el valor es 1 sólo permite introducir
  fechas desde mañana o anteriores.</dd>
</dl>

### Etiqueta

<dl>
  <dt><strong>Texto</strong></dt>
  <dd>Texto adicional que acompaña a la etiqueta.</dd>
</dl>

### Impresión

<dl>
  <dt><strong>Cuerpo</strong></dt>
  <dd>El texto que se imprimirá. Puede consultar más información
  sobre qué puede imprimir en [este artículo](impresión).</dd>
  <dt><strong>Copias</strong></dt>
  <dd>Cuántas copias se imprimirán.</dd>
  <dt><strong>Imprimir al enviar</strong></dt>
  <dd>En vez de aparecer como un botón en el cuestionario y poder imprimirse
  en cualquier momento, sólo se realizará la impresión hasta que se
  termine y envíe el cuestionario. Si la impresión falla o no hay impresora
  no permitirá enviar el cuestionario hasta que se logre imprimir.</dd>
</dl>

# Artículos Relacionados

* [Edición](/edición)
* [Extras](/extras)
* [Dependencias](/dependencias)
