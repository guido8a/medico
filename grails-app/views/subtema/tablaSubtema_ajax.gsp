<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 30%">Tema</th>
            <th style="width: 60%">Descripción</th>
            <th style="width: 10%">Acciones</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${subTemas.size() >0}">
            <g:each in="${subTemas}" status="i" var="subTema">
                <tr data-id="${subTema?.id}">
                    <td style="width: 30%">${subTema.tema?.nombre}</td>
                    <td style="width: 60%">${subTema.nombre}</td>
                    <td style="width: 10%; text-align: center">
                        <a href="#" class="btn btn-xs btn-success btnEditarSubTema" data-id="${subTema?.id}" title="Editar subtema">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="#" class="btn btn-xs btn-danger btnEliminarSubTema" data-id="${subTema?.id}" title="Eliminar subtema">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-info" style="text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> No existen registros</div>
        </g:else>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(".btnEditarSubTema").click(function () {
        var id = $(this).data("id");
        createEditRow(id);
    });

    $(".btnEliminarSubTema").click(function () {
        var id = $(this).data("id");
        deleteRow(id);
    });

</script>