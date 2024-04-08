<%@ page import="medico.Historial; medico.Diagnostico" %>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">
    <thead>
    <tr>
        <th style="width: 15%">Fecha</th>
        %{--<th style="width: 40%">Motivo</th>--}%
        <th style="width: 75%">Diagnóstico</th>
        <th style="width: 10%">Seleccionar</th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%;height: 430px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover table-striped" style="width: 100%">
        <g:if test="${data}">
            <g:each in="${data}" var="dt" status="i">
                <tr>
                    <td style="width: 15%">${dt.hsclfcha}</td>
                    %{--<td style="width: 40%">${dt.hsclmotv}</td>--}%
                    <g:if test="${medico.DiagnosticoxHistorial.findAllByHistorial(medico.Historial.get(dt?.hscl__id)).size() > 0}">
                        <td>
                            <ul>
                                <g:each in="${medico.DiagnosticoxHistorial.findAllByHistorial(medico.Historial.get(dt?.hscl__id))}" var="diagnosticoHistorial">
                                    <li>
                                        ${diagnosticoHistorial?.diagnostico?.descripcion}
                                    </li>
                                </g:each>
                            </ul>
                        </td>
                    </g:if>
                    <g:else>
                        <td style="width: 35%; background-color: #cba51d; text-align: center; font-weight: bold">No existen diagnósticos definidos</td>
                    </g:else>

                    <td style="width: 10%">
                        <div style="text-align: center" class="btnCita" id="reg_${i}" data-desc="${dt?.hsclmotv}" data-paciente="${dt?.pcnt__id}"
                             data-id="${dt?.hscl__id}">
                            <button class="btn btn-xs btn-success"><i class="fa fa-check"></i> Ver Cita</button>
                        </div></td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No existen registros</div>
        </g:else>
    </table>
</div>

<script type="text/javascript">
    $(".btnCita").click(function () {
        var id = $(this).data("id");
        var paciente = $(this).data("paciente");
        location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + paciente + "&id=" + id
    });
</script>