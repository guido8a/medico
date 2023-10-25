
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

<div class="" style="width: 99.7%;height: 500px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${datos}" var="dato" status="i">
            <tr style="width: 100%;">
                <td style="width: 15%;">${dato.diagcdgo}</td>
                <td style="width: 75%;">${dato.diagdscr}</td>
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnSelDiagnostico" title="Seleccionar" data-id="${dato.diag__id}" data-nombre="${dato.diagdscr}" data-codigo="${dato.diagcdgo}">
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
        var codigo = $(this).data("codigo");
        var descripcion = $(this).data("nombre");

        $("#diagnostico").val(id);
        $("#diagnosticoNombre").val(descripcion);
        $("#diagnosticoCodigo").val(codigo);

        cerrarBusqueda();

        return false;
    });

</script>
