<%@ page import="medico.Diagnostico" %>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">
    <thead>
    <tr>
        <th style="width: 15%">Fecha</th>
        <th style="width: 40%">Motivo</th>
        <th style="width: 35%">Diagnóstico</th>
        <th style="width: 10%">Seleccionar</th>
    </tr>
    </thead>
</table>

<div class="" style="width: 99.7%;height: 430px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${data}" var="dt" status="i">
            <tr>
                <td style="width: 14%">${dt.hsclfcha}</td>
                <td style="width: 38%">${dt.hsclmotv}</td>
                <td style="width: 34%">${medico.Diagnostico.get(dt?.diag__id).descripcion}</td>
                <td style="width: 12%">
                    <div style="text-align: center" class="btnCita" id="reg_${i}" data-desc="${dt?.hsclmotv}" data-paciente="${dt?.pcnt__id}" data-codigo="${dt?.diag__id}" data-id="${dt?.hscl__id}">
                        <button class="btn btn-xs btn-success"><i class="fa fa-check"></i></button>
                    </div></td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">
    $(".btnCita").click(function () {
        var id = $(this).data("id");
        var paciente = $(this).data("paciente");
        location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + paciente + "&id=" + id
    });
</script>