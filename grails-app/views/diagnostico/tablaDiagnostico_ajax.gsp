<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}
</style>

<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">Código</th>
            <th style="width: 80%">Descripción</th>
            <th style="width: 10%">Acciones</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${datos}" status="i" var="diagnostico">
            <tr data-id="${diagnostico.diag__id}" style="width: 100%">
                <td style="width: 10%">${diagnostico.diagcdgo}</td>
                <td style="width: 80%">${diagnostico.diagdscr}</td>
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnEditarDiagnostico" data-id="${diagnostico.diag__id}" title="Editar diagnóstico">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="#" class="btn btn-xs btn-danger btnEliminarDiagnostico" data-id="${diagnostico.diag__id}" title="Eliminar diagnóstico">
                        <i class="fas fa-trash"></i>
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(".btnEditarDiagnostico").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });

    $(".btnEliminarDiagnostico").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

</script>