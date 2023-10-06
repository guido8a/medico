
<g:if test="${paciente?.empresa}">
    <div class="row">
        <div class="col-md-2 text-info">
            Empresa
        </div>
        <div class="col-md-3">
           ${paciente?.empresa?.nombre}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.cedula}">
    <div class="row">
        <div class="col-md-2 text-info">
            Cédula
        </div>
        <div class="col-md-3">
            ${paciente?.cedula}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.nombre}">
    <div class="row">
        <div class="col-md-2 text-info">
            Nombre
        </div>
        <div class="col-md-6">
            ${paciente?.nombre}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.apellido}">
    <div class="row">
        <div class="col-md-2 text-info">
            Apellido
        </div>
        <div class="col-md-6">
            ${paciente?.apellido}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.parroquia}">
    <div class="row">
        <div class="col-md-2 text-info">
            Localización
        </div>
        <div class="col-md-8">
            ${paciente?.parroquia?.canton?.provincia?.nombre +  " - " + paciente?.parroquia?.canton?.nombre + " - " + paciente?.parroquia?.nombre}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.direccion}">
<div class="row">
    <div class="col-md-2 text-info">
        Dirección
    </div>
    <div class="col-md-8">
        ${paciente?.direccion}
    </div>
</div>
</g:if>

<g:if test="${paciente?.referencia}">
    <div class="row">
        <div class="col-md-2 text-info">
            Referencia
        </div>
        <div class="col-md-8">
            ${paciente?.referencia}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.mail}">
    <div class="row">
        <div class="col-md-2 text-info">
            Email
        </div>
        <div class="col-md-8">
            ${paciente?.mail}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.telefono}">
    <div class="row">
        <div class="col-md-2 text-info">
            Teléfono
        </div>
        <div class="col-md-8">
            ${paciente?.telefono}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.sexo}">
    <div class="row">
        <div class="col-md-2 text-info">
            Sexo
        </div>
        <div class="col-md-8">
            ${paciente?.sexo == 'M' ? 'MASCULINO' : 'FEMENINO'}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.fechaNacimiento}">
    <div class="row">
        <div class="col-md-2 text-info">
            Fecha nacimiento
        </div>
        <div class="col-md-8">
            ${paciente?.fechaNacimiento?.format("dd-MM-yyyy")}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.grupoSanguineo}">
    <div class="row">
        <div class="col-md-2 text-info">
            Grupo sanguíneo
        </div>
        <div class="col-md-8">
            ${paciente?.grupoSanguineo}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.antecedentes}">
    <div class="row">
        <div class="col-md-2 text-info">
            Antecedentes
        </div>
        <div class="col-md-8">
            ${paciente?.antecedentes}
        </div>
    </div>
</g:if>

<g:if test="${paciente?.activo}">
    <div class="row">
        <div class="col-md-2 text-info">
            Usuario
        </div>
        <div class="col-md-8">
            ${paciente?.activo == '0' ? 'INACTIVO' : 'ACTIVO'}
        </div>
    </div>
</g:if>




