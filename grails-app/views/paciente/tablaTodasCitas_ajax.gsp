<%@ page import="medico.Tratamiento; medico.Historial; medico.Diagnostico" %>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">
    <thead>
    <tr>
        <th style="width: 10%">Fecha</th>
        <th style="width: 40%">Nota de evolución (Diagnósticos)</th>
        <th style="width: 50%">Tratamiento</th>
        <th style="width: 50%">Ver</th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover table-striped" style="width: 100%">
        <g:if test="${citas.size() > 0}">
            <g:each in="${citas}" var="cita">
                <tr>
                    <td style="width: 10%">${cita?.fecha?.format("dd-MM-yyyy")}</td>
                    <td style="width: 40%">
                        <g:if test="${medico.DiagnosticoxHistorial.findAllByHistorial(medico.Historial.get(cita?.id)).size() > 0}">

                            <ul>
                                <g:each in="${medico.DiagnosticoxHistorial.findAllByHistorial(medico.Historial.get(cita?.id))}" var="diagnosticoHistorial">
                                    <li>
                                        ${diagnosticoHistorial?.diagnostico?.descripcion}
                                    </li>
                                </g:each>
                            </ul>

                        </g:if>
                        <g:else>
                            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Sin diagnóstico</div>
                        </g:else>
                    </td>
                    <td style="width: 50%">
                        <g:if test="${medico.Tratamiento.findAllByHistorial(cita).size() > 0}">
                            <table class="table table-bordered table-striped table-condensed table-hover">
                                <thead>
                                <tr style="width: 100%">
                                    <th style="width: 10%">Medicina </th>
                                    <th style="width: 10%">Concentración </th>
                                    <th style="width: 10%">Cantidad </th>
                                    <th style="width: 35%">Prescripción</th>
                                </tr>
                                </thead>
                                <tbody >
                                <g:each in="${medico.Tratamiento.findAllByHistorial(cita)}" status="i" var="tratamiento">
                                    <tr style="width: 100%">
                                        <td style="width: 25%">${tratamiento?.medicina?.codigo ? (tratamiento?.medicina?.codigo  + " - " + tratamiento?.medicina?.descripcion) : ''}</td>
                                        <td style="width: 10%">${tratamiento?.medicina?.concentracion}</td>
                                        <td style="width: 8%">${tratamiento?.cantidad}</td>
                                        <td style="width: 47%">${tratamiento?.descripcion}</td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </g:if>
                        <g:else>
                            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Sin tratamiento</div>
                        </g:else>
                    </td>
                    <td>
                        %{--?paciente=" + '${paciente?.id}' + "&id=" + cita + "&tipo=" + 1--}%
                        <a href="${createLink(controller: 'historial', action: 'cita')}?paciente=${cita?.paciente?.id}&id=${cita?.id}&tipo=1" class="btn btn-xs btn-info"
                        %{--<a href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + "${paciente?.id}" + "&id=" + cita + "&tipo=" + 1--}%
                           title="Información del paciente">
                        <i class="fa fa-search"></i> Ver
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No existen registros</div>
        </g:else>
    </table>
</div>

