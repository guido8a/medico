<g:if test="${!citas}">
    <div class="col-md-8 alert alert-warning">
        <i class="fa fa-minus-circle"></i> <strong>No existen citas</strong>
    </div>
</g:if>
<g:else>
    <div role="main" style="margin-top: 10px;">
        <table class="table table-bordered table-striped table-condensed table-hover">
            <thead>
            <tr>
                <th style="width: 10%">Fecha</th>
                <th style="width: 15%">Motivo</th>
                <th style="width: 15%">Especialista</th>
                <th style="width: 10%">Acciones</th>
            </tr>
            </thead>
        </table>
    </div>

    <div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
        <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
            <tbody>
            <g:each in="${citas}" status="i" var="cita">
                <tr data-id="${cita.id}">
                    <td style="width: 10%">${cita?.fecha?.format("dd-MM-yyyy")}</td>
                    <td style="width: 15%">${cita?.motivo}</td>
                    <td style="width: 15%">${cita?.persona?.apellido + " " + cita?.persona?.nombre}</td>
                    <td style="width: 10%; text-align: center">
                        <a href="#" class="btn btn-xs btn-info btnCita" data-id="${cita?.id}" title="Información de la cita">
                            <i class="fas fa-clipboard-check"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</g:else>

<script type="text/javascript">
    $(".btnCita").click(function () {
        var id = $(this).data("id")
        location.href="${createLink(controller: 'historial', action: 'cita')}?paciente=" + "${paciente?.id}" + "&id=" + id
    });

</script>

