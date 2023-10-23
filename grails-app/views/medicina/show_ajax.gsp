
<g:if test="${medicina?.padre}">
    <div class="row">
        <div class="col-md-2 text-info">
            Padre
        </div>
        <div class="col-md-3">
           ${medicina?.padre?.codigo +  " - " + medicina?.padre?.descripcion}
        </div>
    </div>
</g:if>

<g:if test="${medicina?.codigo}">
    <div class="row">
        <div class="col-md-2 text-info">
            Código
        </div>
        <div class="col-md-6">
            ${medicina?.codigo}
        </div>
    </div>
</g:if>

<g:if test="${medicina?.descripcion}">
    <div class="row">
        <div class="col-md-2 text-info">
            Descripción
        </div>
        <div class="col-md-6">
            ${medicina?.descripcion}
        </div>
    </div>
</g:if>

<g:if test="${medicina?.tipo}">
    <div class="row">
        <div class="col-md-2 text-info">
            Tipo
        </div>
        <div class="col-md-6">
            ${medicina?.tipo}
        </div>
    </div>
</g:if>

<g:if test="${medicina?.forma}">
    <div class="row">
        <div class="col-md-2 text-info">
            Forma
        </div>
        <div class="col-md-6">
            ${medicina?.forma}
        </div>
    </div>
</g:if>

<g:if test="${medicina?.concentracion}">
    <div class="row">
        <div class="col-md-2 text-info">
            Concentración
        </div>
        <div class="col-md-6">
            ${medicina?.concentracion}
        </div>
    </div>
</g:if>

<g:if test="${medicina?.estado}">
    <div class="row">
        <div class="col-md-2 text-info">
            Estado
        </div>
        <div class="col-md-6">
            ${medicina?.estado == 'A' ? 'Activo' : 'Inactivo'}
        </div>
    </div>
</g:if>

<g:if test="${medicina?.observaciones}">
    <div class="row">
        <div class="col-md-2 text-info">
            Observaciones
        </div>
        <div class="col-md-6">
            ${medicina?.observaciones}
        </div>
    </div>
</g:if>


