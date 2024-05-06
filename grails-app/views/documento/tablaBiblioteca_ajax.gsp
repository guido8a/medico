<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">Palabra Clave</th>
            <th style="width: 80%">Descripción</th>
            <th style="width: 10%">Acciones</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${datos.size() > 0}">
            <g:each in="${datos}" status="i" var="documento">
                <tr>
                    <td style="width: 10%">${documento.dcmtclve}</td>
                    <td style="width: 80%">${documento.dcmtdscr}</td>
                    <td style="width: 10%; text-align: center">
                        <a href="#" class="btn btn-xs btn-success btnEditarDocumento" data-id="${documento.dcmt__id}" title="Editar documento">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="#" class="btn btn-xs btn-danger btnEliminarDocumento" data-id="${documento.dcmt__id}" title="Eliminar documento">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> El consultorio no contiene documentos</div>
        </g:else>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(".btnEditarDocumento").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });

    $(".btnEliminarDocumento").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

</script>