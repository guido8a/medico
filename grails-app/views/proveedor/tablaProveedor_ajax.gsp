<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 10%">RUC</th>
            <th style="width: 25%">Nombre</th>
            <th style="width: 15%">Dirección</th>
            <th style="width: 10%">Teléfono</th>
            <th style="width: 10%">Mail</th>
            <th style="width: 10%">Estado</th>
            <th style="width: 12%">Provincia</th>
            <th style="width: 8%">Acciones</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${datos}">
            <g:each in="${datos}" status="i" var="proveedor">
                <tr data-id="${proveedor.prve__id}">
                    <td style="width: 10%">${proveedor.prve_ruc}</td>
                    <td style="width: 25%">${proveedor.prvenmbr}</td>
                    <td style="width: 15%">${proveedor.prvedire}</td>
                    <td style="width: 10%">${proveedor.prvetlfn}</td>
                    <td style="width: 10%">${proveedor.prvemail}</td>
                    <td style="text-align: center; ${proveedor.prveactv == 'S' ? 'color: #00aa00;' : 'color: #701b19;'} width: 10%" >${proveedor.prveetdo == '1' ? "Activo" : 'Inactivo'}</td>
                    <td style="width: 12%">${sri.Proveedor.get(proveedor.prve__id)?.canton?.provincia?.nombre}</td>
                    <td style="width: 8%; text-align: center">
                        <a href="#" class="btn btn-xs btn-success btnEditar" data-id="${proveedor.prve__id}" title="Editar">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="#" class="btn btn-xs btn-danger btnEliminar" data-id="${proveedor.prve__id}" title="Eliminar">
                            <i class="fas fa-trash"></i>
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

<script type="text/javascript">

    $(".btnEditar").click(function () {
        var id = $(this).data("id");
        createEditProveedor(id);
    });

    $(".btnEliminar").click(function () {
        var id = $(this).data("id");
        deleteProveedor(id);
    });

</script>