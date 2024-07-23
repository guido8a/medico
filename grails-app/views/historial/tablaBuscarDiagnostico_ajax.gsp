
<div role="main" style="margin-top: 5px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 15%;">Código</th>
            <th style="width: 75%;">Descripción</th>
            <th style="width: 10%;">Seleccionar</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 400px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${datos}" var="dato" status="i">
            <tr style="width: 100%;">
                <td style="width: 15%;">${dato.diagcdgo}</td>
                <td style="width: 75%;">${dato.diagdscr}</td>
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnSelDiagnostico" title="Seleccionar" data-id="${dato.diag__id}" data-nombre="${dato.diagdscr}" data-codigo="${dato.diagcdgo}" data-cita="${cita?.id}">
                        <i class="fa fa-check"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(".btnSelDiagnostico").click(function () {
        var id = $(this).data("id");
        var cita = $(this).data("cita");

        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'historial', action: 'saveDiagnostico_ajax')}",
            data    : {
                diagnostico: id,
                cita: cita
            },
            success : function (msg) {
                var parts = msg.split("_");
                if(parts[0] === 'ok'){
                    log(parts[1], "success");
                    cerrarBusqueda();
                    %{--cargarUltimaCita('${cita?.id}');--}%
                    %{--cargarBotones('${cita?.id}');--}%
                    cargarComboCita('${cita?.id}');
                }else{
                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                    return false;

                }
            }
        });
        return false;
    });

</script>
