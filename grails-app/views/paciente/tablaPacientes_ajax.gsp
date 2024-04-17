
    <div role="main" style="margin-top: 10px;">
        <table class="table table-bordered table-striped table-condensed table-hover">
            <thead>
            <tr>
                <th style="width: 10%">Cédula</th>
                <th style="width: 15%">Apellido</th>
                <th style="width: 15%">Nombre</th>
                <th style="width: 20%">Empresa</th>
                <th style="width: 20%">Provincia</th>
                <th style="width: 20%">Acciones</th>
            </tr>
            </thead>
        </table>
    </div>

    <div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
        <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
            <tbody>
            <g:if test="${datos}">
                <g:each in="${datos}" status="i" var="paciente">
                    <tr data-id="${paciente.pcnt__id}">
                        <td style="width: 10%">${paciente.pcntcdla}</td>
                        <td style="width: 15%">${paciente.pcntapll}</td>
                        <td style="width: 15%">${paciente.pcntnmbr}</td>
                        <td style="width: 20%; text-align: center">${seguridad.Empresa.get(paciente.empr__id)}</td>
                        <td style="width: 20%; text-align: center">${paciente?.parr__id ? geografia.Parroquia.get(paciente.parr__id)?.canton?.provincia?.nombre : ''}</td>
                        <td style="width: 20%; text-align: center">
                            <a href="${createLink(controller: 'paciente', action: 'historial', id: paciente?.pcnt__id)}" class="btn btn-xs btn-warning" title="Historial del paciente">
                                <i class="fas fa-book"></i> Historial
                            </a>
                            <a href="${createLink(controller: 'paciente', action: 'datos', id: paciente?.pcnt__id)}" class="btn btn-xs btn-info" title="Información del paciente">
                                <i class="fas fa-clipboard-check"></i> Datos
                            </a>
                            <a href="${createLink(controller: 'paciente', action: 'citas', id: paciente?.pcnt__id)}" class="btn btn-xs btn-success" title="Citas del paciente">
                                <i class="fas fa-book"></i> Citas
                            </a>
                        </td>
                    </tr>
                </g:each>
            </g:if>
            <g:else>
                <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No existen registros</div>
            </g:else>
            </tbody>
        </table>
    </div>

