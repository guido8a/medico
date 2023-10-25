<g:if test="${!datos}">
    <div class="col-md-8 alert alert-warning">
            <i class="fa fa-minus-circle"></i> <strong>No existen pacientes</strong>
    </div>
</g:if>
<g:else>
    <div role="main" style="margin-top: 10px;">
        <table class="table table-bordered table-striped table-condensed table-hover">
            <thead>
            <tr>
                <th style="width: 10%">Cédula</th>
                <th style="width: 15%">Apellido</th>
                <th style="width: 15%">Nombre</th>
                <th style="width: 20%">Empresa</th>
                <th style="width: 20%">Provincia</th>
                <th style="width: 10%">Estado</th>
                <th style="width: 10%">Acciones</th>
            </tr>
            </thead>
        </table>
    </div>

    <div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
        <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
            <tbody>
            <g:each in="${datos}" status="i" var="paciente">
                <tr data-id="${paciente.pcnt__id}">
                    <td style="width: 10%">${paciente.pcntcdla}</td>
                    <td style="width: 15%">${paciente.pcntapll}</td>
                    <td style="width: 15%">${paciente.pcntnmbr}</td>
                    <td style="width: 20%; text-align: center">${seguridad.Empresa.get(paciente.empr__id)}</td>
                    <td style="width: 20%; text-align: center">${paciente?.parr__id ? geografia.Parroquia.get(paciente.parr__id)?.canton?.provincia?.nombre : ''}</td>
                    <td style="width: 10%; text-align: center; background-color: ${paciente?.pcntactv == 1 ? '#67a153' : '#e25529'}  ">${paciente?.pcntactv == 1 ? 'Activo' : 'Inactivo'}</td>
                    <td style="width: 10%; text-align: center">
                        <a href="${createLink(controller: 'paciente', action: 'datos', id: paciente?.pcnt__id)}" class="btn btn-xs btn-info" title="Información del paciente">
                            <i class="fas fa-clipboard-check"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</g:else>

